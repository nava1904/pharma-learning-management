/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: no_leading_underscores_for_local_identifiers

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_test/serverpod_test.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'package:pharma_lms_server/src/generated/auth/oidc_client_config.dart'
    as _i5;
import 'package:pharma_lms_server/src/generated/access_reviews/access_review.dart'
    as _i6;
import 'package:pharma_lms_server/src/generated/organization/user.dart' as _i7;
import 'package:pharma_lms_server/src/generated/organization/role.dart' as _i8;
import 'package:pharma_lms_server/src/generated/shared/signature_meaning.dart'
    as _i9;
import 'package:pharma_lms_server/src/generated/training/training_assignment.dart'
    as _i10;
import 'package:pharma_lms_server/src/generated/admin/bulk_import_result.dart'
    as _i11;
import 'package:pharma_lms_server/src/generated/organization/job_role.dart'
    as _i12;
import 'package:pharma_lms_server/src/generated/training/training_matrix.dart'
    as _i13;
import 'package:pharma_lms_server/src/generated/training/training_waiver.dart'
    as _i14;
import 'package:pharma_lms_server/src/generated/analytics/course_analytics.dart'
    as _i15;
import 'package:pharma_lms_server/src/generated/analytics/department_compliance_summary.dart'
    as _i16;
import 'package:pharma_lms_server/src/generated/analytics/audit_readiness_score.dart'
    as _i17;
import 'package:pharma_lms_server/src/generated/analytics/report_definition.dart'
    as _i18;
import 'package:pharma_lms_server/src/generated/analytics/dashboard.dart'
    as _i19;
import 'package:pharma_lms_server/src/generated/analytics/sla_breach.dart'
    as _i20;
import 'package:pharma_lms_server/src/generated/training/certificate.dart'
    as _i21;
import 'package:pharma_lms_server/src/generated/quality/capa.dart' as _i22;
import 'package:pharma_lms_server/src/generated/analytics/compliance_trend_point.dart'
    as _i23;
import 'package:pharma_lms_server/src/generated/analytics/batch_training_analytics.dart'
    as _i24;
import 'package:pharma_lms_server/src/generated/analytics/analytics_event.dart'
    as _i25;
import 'package:pharma_lms_server/src/generated/assessment/question.dart'
    as _i26;
import 'package:pharma_lms_server/src/generated/assessment/question_bank.dart'
    as _i27;
import 'package:pharma_lms_server/src/generated/assessment/assessment.dart'
    as _i28;
import 'package:pharma_lms_server/src/generated/assessment/assessment_attempt.dart'
    as _i29;
import 'package:pharma_lms_server/src/generated/assessment/assessment_result.dart'
    as _i30;
import 'package:pharma_lms_server/src/generated/course/assignment.dart' as _i31;
import 'package:pharma_lms_server/src/generated/course/assignment_submission.dart'
    as _i32;
import 'package:pharma_lms_server/src/generated/audit/audit_trail.dart' as _i33;
import 'package:pharma_lms_server/src/generated/audit/access_log.dart' as _i34;
import 'package:pharma_lms_server/src/generated/training/batch_announcement.dart'
    as _i35;
import 'package:pharma_lms_server/src/generated/training/certificate_template.dart'
    as _i36;
import 'package:pharma_lms_server/src/generated/analytics/compliance_metrics.dart'
    as _i37;
import 'package:pharma_lms_server/src/generated/analytics/user_compliance_metrics.dart'
    as _i38;
import 'package:pharma_lms_server/src/generated/course/module.dart' as _i39;
import 'package:pharma_lms_server/src/generated/course/lesson.dart' as _i40;
import 'package:pharma_lms_server/src/generated/course/course_version.dart'
    as _i41;
import 'package:pharma_lms_server/src/generated/course/qa_validation_result.dart'
    as _i42;
import 'package:pharma_lms_server/src/generated/course/course.dart' as _i43;
import 'package:pharma_lms_server/src/generated/document/document.dart' as _i44;
import 'package:pharma_lms_server/src/generated/document/document_version.dart'
    as _i45;
import 'package:pharma_lms_server/src/generated/document/document_lifecycle.dart'
    as _i46;
import 'package:pharma_lms_server/src/generated/document/approval_workflow.dart'
    as _i47;
import 'package:pharma_lms_server/src/generated/audit/inspection_record.dart'
    as _i48;
import 'package:pharma_lms_server/src/generated/audit/auditor_page_log.dart'
    as _i49;
import 'package:pharma_lms_server/src/generated/audit/inspection_package.dart'
    as _i50;
import 'package:pharma_lms_server/src/generated/training/learner_trainer_message.dart'
    as _i51;
import 'package:pharma_lms_server/src/generated/training/learner_support_thread_summary.dart'
    as _i52;
import 'package:pharma_lms_server/src/generated/course/lesson_block.dart'
    as _i53;
import 'package:pharma_lms_server/src/generated/training/live_class.dart'
    as _i54;
import 'package:pharma_lms_server/src/generated/material/material.dart' as _i55;
import 'package:pharma_lms_server/src/generated/material/material_version.dart'
    as _i56;
import 'package:pharma_lms_server/src/generated/material/material_progress.dart'
    as _i57;
import 'package:pharma_lms_server/src/generated/notifications/messaging_unread_counts.dart'
    as _i58;
import 'package:pharma_lms_server/src/generated/sme/sme_thread_summary.dart'
    as _i59;
import 'package:pharma_lms_server/src/generated/sme/sme_review_comment.dart'
    as _i60;
import 'package:pharma_lms_server/src/generated/notifications/notification.dart'
    as _i61;
import 'package:pharma_lms_server/src/generated/mfa/mfa_status_result.dart'
    as _i62;
import 'package:pharma_lms_server/src/generated/mfa/mfa_enroll_result.dart'
    as _i63;
import 'package:pharma_lms_server/src/generated/notifications/in_app_notification.dart'
    as _i64;
import 'package:pharma_lms_server/src/generated/notifications/notification_template.dart'
    as _i65;
import 'package:pharma_lms_server/src/generated/training/practical_checklist_item.dart'
    as _i66;
import 'package:pharma_lms_server/src/generated/training/observation_log.dart'
    as _i67;
import 'package:pharma_lms_server/src/generated/course/user_competency.dart'
    as _i68;
import 'package:pharma_lms_server/src/generated/course/competency.dart' as _i69;
import 'package:pharma_lms_server/src/generated/organization/organization.dart'
    as _i70;
import 'package:pharma_lms_server/src/generated/organization/site.dart' as _i71;
import 'package:pharma_lms_server/src/generated/organization/department.dart'
    as _i72;
import 'package:pharma_lms_server/src/generated/infrastructure/system_configuration.dart'
    as _i73;
import 'package:pharma_lms_server/src/generated/course/course_review.dart'
    as _i74;
import 'package:pharma_lms_server/src/generated/quality/quality_event.dart'
    as _i75;
import 'package:pharma_lms_server/src/generated/quality/inspection_report.dart'
    as _i76;
import 'package:pharma_lms_server/src/generated/sme/sme_assignment.dart'
    as _i77;
import 'package:pharma_lms_server/src/generated/course/course_sop_link.dart'
    as _i78;
import 'package:pharma_lms_server/src/generated/training/standalone_assignment.dart'
    as _i79;
import 'package:pharma_lms_server/src/generated/training/standalone_assignment_recipient.dart'
    as _i80;
import 'package:pharma_lms_server/src/generated/training/training_batch.dart'
    as _i81;
import 'package:pharma_lms_server/src/generated/training/batch_participant_info.dart'
    as _i82;
import 'package:pharma_lms_server/src/generated/training/training_batch_participant.dart'
    as _i83;
import 'package:pharma_lms_server/src/generated/training/batch_attendance_record.dart'
    as _i84;
import 'package:pharma_lms_server/src/generated/training/enrollment.dart'
    as _i85;
import 'package:pharma_lms_server/src/generated/training/training_record.dart'
    as _i86;
import 'package:pharma_lms_server/src/generated/shared/signature_verification_result.dart'
    as _i87;
import 'package:pharma_lms_server/src/generated/shared/electronic_signature.dart'
    as _i88;
import 'package:pharma_lms_server/src/generated/training/training_record_annotation.dart'
    as _i89;
import 'package:pharma_lms_server/src/generated/organization/user_preference.dart'
    as _i90;
import 'package:pharma_lms_server/src/generated/greetings/greeting.dart'
    as _i91;
import 'package:pharma_lms_server/src/generated/future_calls.dart' as _i92;
import 'package:pharma_lms_server/src/generated/future_calls_generated_models/kafka_event_processor_process_sop_updated_model.dart'
    as _i93;
import 'package:pharma_lms_server/src/generated/future_calls_generated_models/kafka_event_processor_process_employee_created_model.dart'
    as _i94;
import 'package:pharma_lms_server/src/generated/future_calls_generated_models/kafka_event_processor_process_employee_transferred_model.dart'
    as _i95;
import 'package:pharma_lms_server/src/generated/protocol.dart';
import 'package:pharma_lms_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 30)`.
///
/// [testServerOutputMode] Options for controlling test server output during test execution. Defaults to `TestServerOutputMode.normal`.
/// ```dart
/// /// Options for controlling test server output during test execution.
/// enum TestServerOutputMode {
///   /// Default mode - only stderr is printed (stdout suppressed).
///   /// This hides normal startup/shutdown logs while preserving error messages.
///   normal,
///
///   /// All logging - both stdout and stderr are printed.
///   /// Useful for debugging when you need to see all server output.
///   verbose,
///
///   /// No logging - both stdout and stderr are suppressed.
///   /// Completely silent mode, useful when you don't want any server output.
///   silent,
/// }
/// ```
///
/// [configOverride] A function to override the server configuration. This function is called with
/// the default server configuration after it is loaded from the config/ directory
/// and before it is used to start the server. Use this to override particular
/// settings in the server configuration.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
@_i1.isTestGroup
void withServerpod(
  String testGroupName,
  _i1.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  _i2.ServerpodConfig Function(_i2.ServerpodConfig)? configOverride,
  bool? enableSessionLogging,
  _i2.ExperimentalFeatures? experimentalFeatures,
  _i1.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _i2.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _i2.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _i1.TestServerOutputMode? testServerOutputMode,
}) {
  _i1.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _i1.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      experimentalFeatures: experimentalFeatures,
      runtimeParametersBuilder: runtimeParametersBuilder,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
    maybeTestServerOutputMode: testServerOutputMode,
  )(testClosure);
}

class TestEndpoints {
  late final futureCalls = _FutureCalls();

  late final _EmailIdpEndpoint emailIdp;

  late final _JwtRefreshEndpoint jwtRefresh;

  late final _OidcIdpEndpoint oidcIdp;

  late final _AccessReviewEndpoint accessReview;

  late final _AdminUserManagementEndpoint adminUserManagement;

  late final _AdminEndpoint admin;

  late final _AnalyticsEndpoint analytics;

  late final _AssessmentBuilderEndpoint assessmentBuilder;

  late final _AssessmentEndpoint assessment;

  late final _AssignmentEndpoint assignment;

  late final _AuditEndpoint audit;

  late final _AuditFeedEndpoint auditFeed;

  late final _AuditTrailEndpoint auditTrail;

  late final _BatchAnnouncementEndpoint batchAnnouncement;

  late final _CertificateEndpoint certificate;

  late final _CertificateTemplateEndpoint certificateTemplate;

  late final _ComplianceEndpoint compliance;

  late final _CourseBuilderEndpoint courseBuilder;

  late final _CourseEndpoint course;

  late final _DocumentEndpoint document;

  late final _EventEndpoint event;

  late final _InspectionEndpoint inspection;

  late final _LearnerSupportEndpoint learnerSupport;

  late final _LessonBlockEndpoint lessonBlock;

  late final _LiveClassEndpoint liveClass;

  late final _MaterialEndpoint material;

  late final _MessagingEndpoint messaging;

  late final _MfaEndpoint mfa;

  late final _NotificationEndpoint notification;

  late final _NotificationTemplateEndpoint notificationTemplate;

  late final _OqEndpoint oq;

  late final _OrganizationEndpoint organization;

  late final _QaEndpoint qa;

  late final _QualityEventEndpoint qualityEvent;

  late final _RealtimeEndpoint realtime;

  late final _SeedEndpoint seed;

  late final _SmeEndpoint sme;

  late final _SopLinkageEndpoint sopLinkage;

  late final _StandaloneAssignmentEndpoint standaloneAssignment;

  late final _TrainingBatchEndpoint trainingBatch;

  late final _TrainingEndpoint training;

  late final _UserEndpoint user;

  late final _ValidationEndpoint validation;

  late final _GreetingEndpoint greeting;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _i1.InternalTestEndpoints {
  @override
  void initialize(
    _i2.SerializationManager serializationManager,
    _i2.EndpointDispatch endpoints,
  ) {
    emailIdp = _EmailIdpEndpoint(
      endpoints,
      serializationManager,
    );
    jwtRefresh = _JwtRefreshEndpoint(
      endpoints,
      serializationManager,
    );
    oidcIdp = _OidcIdpEndpoint(
      endpoints,
      serializationManager,
    );
    accessReview = _AccessReviewEndpoint(
      endpoints,
      serializationManager,
    );
    adminUserManagement = _AdminUserManagementEndpoint(
      endpoints,
      serializationManager,
    );
    admin = _AdminEndpoint(
      endpoints,
      serializationManager,
    );
    analytics = _AnalyticsEndpoint(
      endpoints,
      serializationManager,
    );
    assessmentBuilder = _AssessmentBuilderEndpoint(
      endpoints,
      serializationManager,
    );
    assessment = _AssessmentEndpoint(
      endpoints,
      serializationManager,
    );
    assignment = _AssignmentEndpoint(
      endpoints,
      serializationManager,
    );
    audit = _AuditEndpoint(
      endpoints,
      serializationManager,
    );
    auditFeed = _AuditFeedEndpoint(
      endpoints,
      serializationManager,
    );
    auditTrail = _AuditTrailEndpoint(
      endpoints,
      serializationManager,
    );
    batchAnnouncement = _BatchAnnouncementEndpoint(
      endpoints,
      serializationManager,
    );
    certificate = _CertificateEndpoint(
      endpoints,
      serializationManager,
    );
    certificateTemplate = _CertificateTemplateEndpoint(
      endpoints,
      serializationManager,
    );
    compliance = _ComplianceEndpoint(
      endpoints,
      serializationManager,
    );
    courseBuilder = _CourseBuilderEndpoint(
      endpoints,
      serializationManager,
    );
    course = _CourseEndpoint(
      endpoints,
      serializationManager,
    );
    document = _DocumentEndpoint(
      endpoints,
      serializationManager,
    );
    event = _EventEndpoint(
      endpoints,
      serializationManager,
    );
    inspection = _InspectionEndpoint(
      endpoints,
      serializationManager,
    );
    learnerSupport = _LearnerSupportEndpoint(
      endpoints,
      serializationManager,
    );
    lessonBlock = _LessonBlockEndpoint(
      endpoints,
      serializationManager,
    );
    liveClass = _LiveClassEndpoint(
      endpoints,
      serializationManager,
    );
    material = _MaterialEndpoint(
      endpoints,
      serializationManager,
    );
    messaging = _MessagingEndpoint(
      endpoints,
      serializationManager,
    );
    mfa = _MfaEndpoint(
      endpoints,
      serializationManager,
    );
    notification = _NotificationEndpoint(
      endpoints,
      serializationManager,
    );
    notificationTemplate = _NotificationTemplateEndpoint(
      endpoints,
      serializationManager,
    );
    oq = _OqEndpoint(
      endpoints,
      serializationManager,
    );
    organization = _OrganizationEndpoint(
      endpoints,
      serializationManager,
    );
    qa = _QaEndpoint(
      endpoints,
      serializationManager,
    );
    qualityEvent = _QualityEventEndpoint(
      endpoints,
      serializationManager,
    );
    realtime = _RealtimeEndpoint(
      endpoints,
      serializationManager,
    );
    seed = _SeedEndpoint(
      endpoints,
      serializationManager,
    );
    sme = _SmeEndpoint(
      endpoints,
      serializationManager,
    );
    sopLinkage = _SopLinkageEndpoint(
      endpoints,
      serializationManager,
    );
    standaloneAssignment = _StandaloneAssignmentEndpoint(
      endpoints,
      serializationManager,
    );
    trainingBatch = _TrainingBatchEndpoint(
      endpoints,
      serializationManager,
    );
    training = _TrainingEndpoint(
      endpoints,
      serializationManager,
    );
    user = _UserEndpoint(
      endpoints,
      serializationManager,
    );
    validation = _ValidationEndpoint(
      endpoints,
      serializationManager,
    );
    greeting = _GreetingEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _FutureCalls {
  late final capaEffectivenessWorker = _CapaEffectivenessWorkerFutureCall();

  late final certificationExpiryWorker = _CertificationExpiryWorkerFutureCall();

  late final complianceMonitorWorker = _ComplianceMonitorWorkerFutureCall();

  late final failedLoginLockoutWorker = _FailedLoginLockoutWorkerFutureCall();

  late final kafkaEventProcessor = _KafkaEventProcessorFutureCall();

  late final retentionArchivalWorker = _RetentionArchivalWorkerFutureCall();
}

class _EmailIdpEndpoint {
  _EmailIdpEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.AuthSuccess> login(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String password,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'login',
          parameters: _i1.testObjectToJson({
            'email': email,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i2.UuidValue> startRegistration(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'startRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'startRegistration',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i2.UuidValue>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> verifyRegistrationCode(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'verifyRegistrationCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'verifyRegistrationCode',
          parameters: _i1.testObjectToJson({
            'accountRequestId': accountRequestId,
            'verificationCode': verificationCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i4.AuthSuccess> finishRegistration(
    _i1.TestSessionBuilder sessionBuilder, {
    required String registrationToken,
    required String password,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'finishRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'finishRegistration',
          parameters: _i1.testObjectToJson({
            'registrationToken': registrationToken,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i2.UuidValue> startPasswordReset(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'startPasswordReset',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'startPasswordReset',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i2.UuidValue>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> verifyPasswordResetCode(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'verifyPasswordResetCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'verifyPasswordResetCode',
          parameters: _i1.testObjectToJson({
            'passwordResetRequestId': passwordResetRequestId,
            'verificationCode': verificationCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> finishPasswordReset(
    _i1.TestSessionBuilder sessionBuilder, {
    required String finishPasswordResetToken,
    required String newPassword,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'finishPasswordReset',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'finishPasswordReset',
          parameters: _i1.testObjectToJson({
            'finishPasswordResetToken': finishPasswordResetToken,
            'newPassword': newPassword,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> hasAccount(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'hasAccount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'hasAccount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _JwtRefreshEndpoint {
  _JwtRefreshEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.AuthSuccess> refreshAccessToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required String refreshToken,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jwtRefresh',
            method: 'refreshAccessToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jwtRefresh',
          methodName: 'refreshAccessToken',
          parameters: _i1.testObjectToJson({'refreshToken': refreshToken}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _OidcIdpEndpoint {
  _OidcIdpEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<bool> hasAccount(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oidcIdp',
            method: 'hasAccount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oidcIdp',
          methodName: 'hasAccount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i5.OidcClientConfig> getClientConfig(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oidcIdp',
            method: 'getClientConfig',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oidcIdp',
          methodName: 'getClientConfig',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i5.OidcClientConfig>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i4.AuthSuccess> login(
    _i1.TestSessionBuilder sessionBuilder, {
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oidcIdp',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oidcIdp',
          methodName: 'login',
          parameters: _i1.testObjectToJson({
            'code': code,
            'codeVerifier': codeVerifier,
            'redirectUri': redirectUri,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AccessReviewEndpoint {
  _AccessReviewEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i6.AccessReview>> getAccessReviews(
    _i1.TestSessionBuilder sessionBuilder,
    int windowId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accessReview',
            method: 'getAccessReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accessReview',
          methodName: 'getAccessReviews',
          parameters: _i1.testObjectToJson({'windowId': windowId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i6.AccessReview>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> recertify(
    _i1.TestSessionBuilder sessionBuilder, {
    required int reviewId,
    required String justification,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accessReview',
            method: 'recertify',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accessReview',
          methodName: 'recertify',
          parameters: _i1.testObjectToJson({
            'reviewId': reviewId,
            'justification': justification,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> revoke(
    _i1.TestSessionBuilder sessionBuilder, {
    required int reviewId,
    required String justification,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accessReview',
            method: 'revoke',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accessReview',
          methodName: 'revoke',
          parameters: _i1.testObjectToJson({
            'reviewId': reviewId,
            'justification': justification,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> signReview(
    _i1.TestSessionBuilder sessionBuilder, {
    required int windowId,
    required String password,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accessReview',
            method: 'signReview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accessReview',
          methodName: 'signReview',
          parameters: _i1.testObjectToJson({
            'windowId': windowId,
            'password': password,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> exportSignedPdf(
    _i1.TestSessionBuilder sessionBuilder, {
    required int windowId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accessReview',
            method: 'exportSignedPdf',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accessReview',
          methodName: 'exportSignedPdf',
          parameters: _i1.testObjectToJson({'windowId': windowId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminUserManagementEndpoint {
  _AdminUserManagementEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i7.PharmaUser>> listUsers(
    _i1.TestSessionBuilder sessionBuilder, {
    String? role,
    String? status,
    String? organizationName,
    String? departmentName,
    String? search,
    required int page,
    required int perPage,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUserManagement',
            method: 'listUsers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUserManagement',
          methodName: 'listUsers',
          parameters: _i1.testObjectToJson({
            'role': role,
            'status': status,
            'organizationName': organizationName,
            'departmentName': departmentName,
            'search': search,
            'page': page,
            'perPage': perPage,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i7.PharmaUser>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.PharmaUser?> getUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUserManagement',
            method: 'getUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUserManagement',
          methodName: 'getUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.PharmaUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.PharmaUser> createUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String firstName,
    required String lastName,
    String? employeeId,
    int? organizationId,
    int? departmentId,
    int? jobRoleId,
    int? siteId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUserManagement',
            method: 'createUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUserManagement',
          methodName: 'createUser',
          parameters: _i1.testObjectToJson({
            'email': email,
            'firstName': firstName,
            'lastName': lastName,
            'employeeId': employeeId,
            'organizationId': organizationId,
            'departmentId': departmentId,
            'jobRoleId': jobRoleId,
            'siteId': siteId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.PharmaUser>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.PharmaUser?> updateUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    String? firstName,
    String? lastName,
    int? organizationId,
    int? departmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUserManagement',
            method: 'updateUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUserManagement',
          methodName: 'updateUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'firstName': firstName,
            'lastName': lastName,
            'organizationId': organizationId,
            'departmentId': departmentId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.PharmaUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deactivateUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUserManagement',
            method: 'deactivateUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUserManagement',
          methodName: 'deactivateUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i8.Role>> listPortalRoles(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUserManagement',
            method: 'listPortalRoles',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUserManagement',
          methodName: 'listPortalRoles',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i8.Role>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<String>> getUserPortalRoles(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUserManagement',
            method: 'getUserPortalRoles',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUserManagement',
          methodName: 'getUserPortalRoles',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> setUserPortalRole(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required String roleCode,
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUserManagement',
            method: 'setUserPortalRole',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUserManagement',
          methodName: 'setUserPortalRole',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'roleCode': roleCode,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminEndpoint {
  _AdminEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i9.SignatureMeaning>> listSignatureMeanings(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listSignatureMeanings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listSignatureMeanings',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.SignatureMeaning>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.SignatureMeaning> createSignatureMeaning(
    _i1.TestSessionBuilder sessionBuilder, {
    required String meaning,
    required bool isActive,
    required int orderIndex,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'createSignatureMeaning',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'createSignatureMeaning',
          parameters: _i1.testObjectToJson({
            'meaning': meaning,
            'isActive': isActive,
            'orderIndex': orderIndex,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i9.SignatureMeaning>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.SignatureMeaning> updateSignatureMeaning(
    _i1.TestSessionBuilder sessionBuilder, {
    required int id,
    String? meaning,
    bool? isActive,
    int? orderIndex,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'updateSignatureMeaning',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updateSignatureMeaning',
          parameters: _i1.testObjectToJson({
            'id': id,
            'meaning': meaning,
            'isActive': isActive,
            'orderIndex': orderIndex,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i9.SignatureMeaning>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.TrainingAssignment>> assignTrainingToDepartment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int departmentId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String? reason,
    required String source,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'assignTrainingToDepartment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'assignTrainingToDepartment',
          parameters: _i1.testObjectToJson({
            'departmentId': departmentId,
            'courseVersionId': courseVersionId,
            'assignedById': assignedById,
            'dueDate': dueDate,
            'reason': reason,
            'source': source,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.TrainingAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.PharmaUser> createUserWithRole(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'createUserWithRole',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'createUserWithRole',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.PharmaUser>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.BulkImportResult> bulkImportUsers(
    _i1.TestSessionBuilder sessionBuilder, {
    required String csvBase64,
    required int assignedById,
    DateTime? dueDate,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'bulkImportUsers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'bulkImportUsers',
          parameters: _i1.testObjectToJson({
            'csvBase64': csvBase64,
            'assignedById': assignedById,
            'dueDate': dueDate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.BulkImportResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.BulkImportResult> bulkImportTrainingMatrix(
    _i1.TestSessionBuilder sessionBuilder, {
    required String csvBase64,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'bulkImportTrainingMatrix',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'bulkImportTrainingMatrix',
          parameters: _i1.testObjectToJson({'csvBase64': csvBase64}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.BulkImportResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.JobRole> updateJobRoleTrainingMatrix(
    _i1.TestSessionBuilder sessionBuilder, {
    required int jobRoleId,
    required String trainingMatrixJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'updateJobRoleTrainingMatrix',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updateJobRoleTrainingMatrix',
          parameters: _i1.testObjectToJson({
            'jobRoleId': jobRoleId,
            'trainingMatrixJson': trainingMatrixJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.JobRole>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<int>> getRoleBasedCurriculum(
    _i1.TestSessionBuilder sessionBuilder,
    int jobRoleId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getRoleBasedCurriculum',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getRoleBasedCurriculum',
          parameters: _i1.testObjectToJson({'jobRoleId': jobRoleId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.TrainingMatrix>> listTrainingMatrixEntries(
    _i1.TestSessionBuilder sessionBuilder, {
    int? siteId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listTrainingMatrixEntries',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listTrainingMatrixEntries',
          parameters: _i1.testObjectToJson({'siteId': siteId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.TrainingMatrix>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.TrainingMatrix> upsertTrainingMatrixEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required int jobRoleId,
    required int courseId,
    required bool isMandatory,
    int? dueDaysFromHire,
    int? retrainingIntervalDays,
    int? siteId,
    int? createdById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'upsertTrainingMatrixEntry',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'upsertTrainingMatrixEntry',
          parameters: _i1.testObjectToJson({
            'jobRoleId': jobRoleId,
            'courseId': courseId,
            'isMandatory': isMandatory,
            'dueDaysFromHire': dueDaysFromHire,
            'retrainingIntervalDays': retrainingIntervalDays,
            'siteId': siteId,
            'createdById': createdById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.TrainingMatrix>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteTrainingMatrixEntry(
    _i1.TestSessionBuilder sessionBuilder, {
    required int jobRoleId,
    required int courseId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'deleteTrainingMatrixEntry',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'deleteTrainingMatrixEntry',
          parameters: _i1.testObjectToJson({
            'jobRoleId': jobRoleId,
            'courseId': courseId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.TrainingAssignment>> assignRoleBasedTraining(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int jobRoleId,
    required int assignedById,
    required DateTime dueDate,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'assignRoleBasedTraining',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'assignRoleBasedTraining',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'jobRoleId': jobRoleId,
            'assignedById': assignedById,
            'dueDate': dueDate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.TrainingAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> lockUserByEmail(
    _i1.TestSessionBuilder sessionBuilder,
    String email,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'lockUserByEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'lockUserByEmail',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.TrainingWaiver> requestTrainingWaiver(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int courseId,
    required int requestedById,
    required String requestReason,
    String? evidenceStoragePath,
    DateTime? expiresAt,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'requestTrainingWaiver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'requestTrainingWaiver',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'courseId': courseId,
            'requestedById': requestedById,
            'requestReason': requestReason,
            'evidenceStoragePath': evidenceStoragePath,
            'expiresAt': expiresAt,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i14.TrainingWaiver>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i14.TrainingWaiver>> listTrainingWaivers(
    _i1.TestSessionBuilder sessionBuilder, {
    int? userId,
    String? status,
    int? courseId,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listTrainingWaivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listTrainingWaivers',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'status': status,
            'courseId': courseId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i14.TrainingWaiver>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.TrainingWaiver> approveTrainingWaiver(
    _i1.TestSessionBuilder sessionBuilder, {
    required int waiverId,
    required int approvedById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'approveTrainingWaiver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'approveTrainingWaiver',
          parameters: _i1.testObjectToJson({
            'waiverId': waiverId,
            'approvedById': approvedById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i14.TrainingWaiver>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.TrainingWaiver> rejectTrainingWaiver(
    _i1.TestSessionBuilder sessionBuilder, {
    required int waiverId,
    required int approvedById,
    required String rejectionReason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'rejectTrainingWaiver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'rejectTrainingWaiver',
          parameters: _i1.testObjectToJson({
            'waiverId': waiverId,
            'approvedById': approvedById,
            'rejectionReason': rejectionReason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i14.TrainingWaiver>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> unlockUserByEmail(
    _i1.TestSessionBuilder sessionBuilder,
    String email,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'unlockUserByEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'unlockUserByEmail',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i7.PharmaUser>> listUsers(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int perPage,
    String? roleCode,
    String? status,
    String? searchQuery,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listUsers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listUsers',
          parameters: _i1.testObjectToJson({
            'page': page,
            'perPage': perPage,
            'roleCode': roleCode,
            'status': status,
            'searchQuery': searchQuery,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i7.PharmaUser>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getUserCount(
    _i1.TestSessionBuilder sessionBuilder, {
    String? roleCode,
    String? status,
    String? searchQuery,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getUserCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getUserCount',
          parameters: _i1.testObjectToJson({
            'roleCode': roleCode,
            'status': status,
            'searchQuery': searchQuery,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.PharmaUser?> getUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.PharmaUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.PharmaUser?> updateUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    String? firstName,
    String? lastName,
    int? departmentId,
    int? jobRoleId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'updateUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updateUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'firstName': firstName,
            'lastName': lastName,
            'departmentId': departmentId,
            'jobRoleId': jobRoleId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.PharmaUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deactivateUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int deactivatedById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'deactivateUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'deactivateUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'deactivatedById': deactivatedById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> terminateUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required DateTime terminationDate,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'terminateUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'terminateUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'terminationDate': terminationDate,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AnalyticsEndpoint {
  _AnalyticsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i15.CourseAnalytics> getCourseAnalytics(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getCourseAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getCourseAnalytics',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i15.CourseAnalytics>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, double>> getTrainingCompletionRate(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getTrainingCompletionRate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getTrainingCompletionRate',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, double>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getSystemHealth(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getSystemHealth',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getSystemHealth',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> triggerManualJob(
    _i1.TestSessionBuilder sessionBuilder, {
    required String jobName,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'triggerManualJob',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'triggerManualJob',
          parameters: _i1.testObjectToJson({'jobName': jobName}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> runCertExpiryCheck(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'runCertExpiryCheck',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'runCertExpiryCheck',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> runNotificationWorker(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'runNotificationWorker',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'runNotificationWorker',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> runComplianceCalc(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'runComplianceCalc',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'runComplianceCalc',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> runAuditTrailIntegrityCheck(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'runAuditTrailIntegrityCheck',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'runAuditTrailIntegrityCheck',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getAdminDashboardKpis(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getAdminDashboardKpis',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getAdminDashboardKpis',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i16.DepartmentComplianceSummary>>
  getDepartmentComplianceSummary(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getDepartmentComplianceSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getDepartmentComplianceSummary',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i16.DepartmentComplianceSummary>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getCertificationExpiryRiskCount(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getCertificationExpiryRiskCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getCertificationExpiryRiskCount',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.AuditReadinessScore> getAuditReadinessScore(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getAuditReadinessScore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getAuditReadinessScore',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.AuditReadinessScore>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i18.ReportDefinition>> listReportDefinitions(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'listReportDefinitions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'listReportDefinitions',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i18.ReportDefinition>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i19.Dashboard>> listDashboards(
    _i1.TestSessionBuilder sessionBuilder, {
    int? roleId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'listDashboards',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'listDashboards',
          parameters: _i1.testObjectToJson({'roleId': roleId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i19.Dashboard>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i20.SlaBreach>> getOpenSlaBreaches(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getOpenSlaBreaches',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getOpenSlaBreaches',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i20.SlaBreach>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i7.PharmaUser>> getNonCompliantEmployees(
    _i1.TestSessionBuilder sessionBuilder, {
    int? departmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getNonCompliantEmployees',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getNonCompliantEmployees',
          parameters: _i1.testObjectToJson({'departmentId': departmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i7.PharmaUser>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, List<_i21.Certificate>>>
  getUpcomingExpirationsByDepartment(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getUpcomingExpirationsByDepartment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getUpcomingExpirationsByDepartment',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, List<_i21.Certificate>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.TrainingAssignment>> getRecentAssignments(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getRecentAssignments',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getRecentAssignments',
          parameters: _i1.testObjectToJson({'limit': limit}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.TrainingAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i22.Capa>> getOpenCapasRequiringTraining(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getOpenCapasRequiringTraining',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getOpenCapasRequiringTraining',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i22.Capa>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getPendingQaApprovalsCount(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getPendingQaApprovalsCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getPendingQaApprovalsCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> getSopRetrainingQueue(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getSopRetrainingQueue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getSopRetrainingQueue',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getDlqFailureCount(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getDlqFailureCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getDlqFailureCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getTrainingVsDeviationCorrelation(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getTrainingVsDeviationCorrelation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getTrainingVsDeviationCorrelation',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getComplianceDeviationOverlay(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getComplianceDeviationOverlay',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getComplianceDeviationOverlay',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getSlaSummary(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getSlaSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getSlaSummary',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i23.ComplianceTrendPoint>> getComplianceTrend(
    _i1.TestSessionBuilder sessionBuilder, {
    required int months,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getComplianceTrend',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getComplianceTrend',
          parameters: _i1.testObjectToJson({'months': months}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i23.ComplianceTrendPoint>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i24.BatchTrainingAnalytics?> getBatchTrainingAnalytics(
    _i1.TestSessionBuilder sessionBuilder,
    int batchId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getBatchTrainingAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getBatchTrainingAnalytics',
          parameters: _i1.testObjectToJson({'batchId': batchId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i24.BatchTrainingAnalytics?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<double> getSopRetrainingVelocity(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getSopRetrainingVelocity',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getSopRetrainingVelocity',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<double>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i25.AnalyticsEvent> streamAnalytics(
    _i1.TestSessionBuilder sessionBuilder,
    String channel,
  ) {
    var _localTestStreamManager = _i1.TestStreamManager<_i25.AnalyticsEvent>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'analytics',
              method: 'streamAnalytics',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'analytics',
              methodName: 'streamAnalytics',
              arguments: {'channel': channel},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<List<Map<String, String>>> getRecentActivity(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getRecentActivity',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getRecentActivity',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> getOverdueDashboardItems(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getOverdueDashboardItems',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getOverdueDashboardItems',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getOpenQualityEventsCount(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getOpenQualityEventsCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getOpenQualityEventsCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i20.SlaBreach>> getSlaBreaches(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getSlaBreaches',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getSlaBreaches',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i20.SlaBreach>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> getMonthlyTrainingHours(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getMonthlyTrainingHours',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getMonthlyTrainingHours',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> getWeeklyLearningProgress(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getWeeklyLearningProgress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getWeeklyLearningProgress',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<double> getUserAverageQuizScore(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getUserAverageQuizScore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getUserAverageQuizScore',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<double>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getUserCompletedAssessmentAttemptCount(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getUserCompletedAssessmentAttemptCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getUserCompletedAssessmentAttemptCount',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getUserLearningStreak(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getUserLearningStreak',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getUserLearningStreak',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> getUpcomingDueDates(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getUpcomingDueDates',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getUpcomingDueDates',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> getComplianceAlerts(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getComplianceAlerts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getComplianceAlerts',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> exportCourseAnalyticsCsv(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'exportCourseAnalyticsCsv',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'exportCourseAnalyticsCsv',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> exportCompletionMatrixCsv(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'exportCompletionMatrixCsv',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'exportCompletionMatrixCsv',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> exportLearnerProgressCsv(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'exportLearnerProgressCsv',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'exportLearnerProgressCsv',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getEmployeeDashboardSummary(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getEmployeeDashboardSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getEmployeeDashboardSummary',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AssessmentBuilderEndpoint {
  _AssessmentBuilderEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i26.Question> createQuestion(
    _i1.TestSessionBuilder sessionBuilder, {
    required int questionBankId,
    required String text,
    required String questionType,
    required String optionsJson,
    required String correctAnswer,
    String? difficulty,
    String? regulatoryTag,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'createQuestion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'createQuestion',
          parameters: _i1.testObjectToJson({
            'questionBankId': questionBankId,
            'text': text,
            'questionType': questionType,
            'optionsJson': optionsJson,
            'correctAnswer': correctAnswer,
            'difficulty': difficulty,
            'regulatoryTag': regulatoryTag,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.Question>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i26.Question> updateQuestion(
    _i1.TestSessionBuilder sessionBuilder, {
    required int questionId,
    String? text,
    String? questionType,
    String? optionsJson,
    String? correctAnswer,
    String? difficulty,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'updateQuestion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'updateQuestion',
          parameters: _i1.testObjectToJson({
            'questionId': questionId,
            'text': text,
            'questionType': questionType,
            'optionsJson': optionsJson,
            'correctAnswer': correctAnswer,
            'difficulty': difficulty,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.Question>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteQuestion(
    _i1.TestSessionBuilder sessionBuilder, {
    required int questionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'deleteQuestion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'deleteQuestion',
          parameters: _i1.testObjectToJson({'questionId': questionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i27.QuestionBank> createQuestionBank(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    required int organizationId,
    String? tagsJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'createQuestionBank',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'createQuestionBank',
          parameters: _i1.testObjectToJson({
            'name': name,
            'organizationId': organizationId,
            'tagsJson': tagsJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i27.QuestionBank>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i27.QuestionBank> updateQuestionBank(
    _i1.TestSessionBuilder sessionBuilder, {
    required int questionBankId,
    String? name,
    String? tagsJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'updateQuestionBank',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'updateQuestionBank',
          parameters: _i1.testObjectToJson({
            'questionBankId': questionBankId,
            'name': name,
            'tagsJson': tagsJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i27.QuestionBank>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getQuestionBankDetails(
    _i1.TestSessionBuilder sessionBuilder, {
    required int questionBankId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'getQuestionBankDetails',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'getQuestionBankDetails',
          parameters: _i1.testObjectToJson({'questionBankId': questionBankId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i28.Assessment> createAssessment(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'createAssessment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'createAssessment',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i28.Assessment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i28.Assessment> updateAssessment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assessmentId,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
    bool? showAnswers,
    bool? showSubmissionHistory,
    int? limitQuestions,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'updateAssessment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'updateAssessment',
          parameters: _i1.testObjectToJson({
            'assessmentId': assessmentId,
            'passingScore': passingScore,
            'randomize': randomize,
            'timeLimitMinutes': timeLimitMinutes,
            'maxAttempts': maxAttempts,
            'questionsToDisplay': questionsToDisplay,
            'showAnswers': showAnswers,
            'showSubmissionHistory': showSubmissionHistory,
            'limitQuestions': limitQuestions,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i28.Assessment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> validateAssessmentForSubmission(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assessmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'validateAssessmentForSubmission',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'validateAssessmentForSubmission',
          parameters: _i1.testObjectToJson({'assessmentId': assessmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i28.Assessment>> listAssessments(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'listAssessments',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'listAssessments',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i28.Assessment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i29.AssessmentAttempt>> listAssessmentAttempts(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assessmentId,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessmentBuilder',
            method: 'listAssessmentAttempts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessmentBuilder',
          methodName: 'listAssessmentAttempts',
          parameters: _i1.testObjectToJson({
            'assessmentId': assessmentId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i29.AssessmentAttempt>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AssessmentEndpoint {
  _AssessmentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i28.Assessment?> getAssessmentForCourse(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'getAssessmentForCourse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'getAssessmentForCourse',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i28.Assessment?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i26.Question>> getQuestions(
    _i1.TestSessionBuilder sessionBuilder,
    int questionBankId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'getQuestions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'getQuestions',
          parameters: _i1.testObjectToJson({'questionBankId': questionBankId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i26.Question>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i29.AssessmentAttempt> startAttempt(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int assessmentId,
    int? enrollmentId,
    required bool skipInterAttemptCooldown,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'startAttempt',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'startAttempt',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'assessmentId': assessmentId,
            'enrollmentId': enrollmentId,
            'skipInterAttemptCooldown': skipInterAttemptCooldown,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i29.AssessmentAttempt>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i29.AssessmentAttempt>> listCompletedAttemptsForUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'listCompletedAttemptsForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'listCompletedAttemptsForUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i29.AssessmentAttempt>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getAttemptCount(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int assessmentId,
    int? enrollmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'getAttemptCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'getAttemptCount',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'assessmentId': assessmentId,
            'enrollmentId': enrollmentId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i29.AssessmentAttempt> submitAttempt(
    _i1.TestSessionBuilder sessionBuilder, {
    required int attemptId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'submitAttempt',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'submitAttempt',
          parameters: _i1.testObjectToJson({'attemptId': attemptId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i29.AssessmentAttempt>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i30.AssessmentResult> recordAnswer(
    _i1.TestSessionBuilder sessionBuilder, {
    required int attemptId,
    required int questionId,
    required String answer,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'recordAnswer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'recordAnswer',
          parameters: _i1.testObjectToJson({
            'attemptId': attemptId,
            'questionId': questionId,
            'answer': answer,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i30.AssessmentResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i27.QuestionBank>> listQuestionBanks(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'listQuestionBanks',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'listQuestionBanks',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i27.QuestionBank>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i27.QuestionBank> createQuestionBank(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    required int organizationId,
    String? tagsJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'createQuestionBank',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'createQuestionBank',
          parameters: _i1.testObjectToJson({
            'name': name,
            'organizationId': organizationId,
            'tagsJson': tagsJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i27.QuestionBank>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i26.Question>> generateRandomAssessment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int questionBankId,
    required int count,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'generateRandomAssessment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'generateRandomAssessment',
          parameters: _i1.testObjectToJson({
            'questionBankId': questionBankId,
            'count': count,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i26.Question>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i26.Question>> importQuestionsToBank(
    _i1.TestSessionBuilder sessionBuilder, {
    required int targetBankId,
    required List<Map<String, dynamic>> questions,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'importQuestionsToBank',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'importQuestionsToBank',
          parameters: _i1.testObjectToJson({
            'targetBankId': targetBankId,
            'questions': questions,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i26.Question>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i30.AssessmentResult>> listUngradedResults(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assessmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'listUngradedResults',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'listUngradedResults',
          parameters: _i1.testObjectToJson({'assessmentId': assessmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i30.AssessmentResult>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i30.AssessmentResult> gradeResult(
    _i1.TestSessionBuilder sessionBuilder, {
    required int resultId,
    required bool correct,
    int? manualScore,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'gradeResult',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'gradeResult',
          parameters: _i1.testObjectToJson({
            'resultId': resultId,
            'correct': correct,
            'manualScore': manualScore,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i30.AssessmentResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i30.AssessmentResult>> listResultsForAttempt(
    _i1.TestSessionBuilder sessionBuilder, {
    required int attemptId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assessment',
            method: 'listResultsForAttempt',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assessment',
          methodName: 'listResultsForAttempt',
          parameters: _i1.testObjectToJson({'attemptId': attemptId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i30.AssessmentResult>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AssignmentEndpoint {
  _AssignmentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i31.Assignment> createAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int lessonId,
    required String title,
    String? instructions,
    String? allowedFileTypes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assignment',
            method: 'createAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assignment',
          methodName: 'createAssignment',
          parameters: _i1.testObjectToJson({
            'lessonId': lessonId,
            'title': title,
            'instructions': instructions,
            'allowedFileTypes': allowedFileTypes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i31.Assignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i31.Assignment?> getAssignment(
    _i1.TestSessionBuilder sessionBuilder,
    int assignmentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assignment',
            method: 'getAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assignment',
          methodName: 'getAssignment',
          parameters: _i1.testObjectToJson({'assignmentId': assignmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i31.Assignment?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i31.Assignment>> listByLesson(
    _i1.TestSessionBuilder sessionBuilder, {
    required int lessonId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assignment',
            method: 'listByLesson',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assignment',
          methodName: 'listByLesson',
          parameters: _i1.testObjectToJson({'lessonId': lessonId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i31.Assignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i31.Assignment> updateAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
    String? title,
    String? instructions,
    String? allowedFileTypes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assignment',
            method: 'updateAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assignment',
          methodName: 'updateAssignment',
          parameters: _i1.testObjectToJson({
            'assignmentId': assignmentId,
            'title': title,
            'instructions': instructions,
            'allowedFileTypes': allowedFileTypes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i31.Assignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assignment',
            method: 'deleteAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assignment',
          methodName: 'deleteAssignment',
          parameters: _i1.testObjectToJson({'assignmentId': assignmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i32.AssignmentSubmission> submitAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
    int? userId,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assignment',
            method: 'submitAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assignment',
          methodName: 'submitAssignment',
          parameters: _i1.testObjectToJson({
            'assignmentId': assignmentId,
            'userId': userId,
            'submissionUrl': submissionUrl,
            'storageKey': storageKey,
            'fileName': fileName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.AssignmentSubmission>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i32.AssignmentSubmission>> listSubmissions(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assignment',
            method: 'listSubmissions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assignment',
          methodName: 'listSubmissions',
          parameters: _i1.testObjectToJson({'assignmentId': assignmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i32.AssignmentSubmission>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i32.AssignmentSubmission> gradeSubmission(
    _i1.TestSessionBuilder sessionBuilder, {
    required int submissionId,
    required int grade,
    String? feedback,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'assignment',
            method: 'gradeSubmission',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'assignment',
          methodName: 'gradeSubmission',
          parameters: _i1.testObjectToJson({
            'submissionId': submissionId,
            'grade': grade,
            'feedback': feedback,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.AssignmentSubmission>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AuditEndpoint {
  _AuditEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<void> logReportExport(
    _i1.TestSessionBuilder sessionBuilder, {
    required String reportType,
    required String hashSha256,
    int? exportedById,
    String? filterParamsJson,
    int? recordCount,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'audit',
            method: 'logReportExport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'audit',
          methodName: 'logReportExport',
          parameters: _i1.testObjectToJson({
            'reportType': reportType,
            'hashSha256': hashSha256,
            'exportedById': exportedById,
            'filterParamsJson': filterParamsJson,
            'recordCount': recordCount,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i33.AuditTrail>> getMyAuditTrail(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
    int? userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'audit',
            method: 'getMyAuditTrail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'audit',
          methodName: 'getMyAuditTrail',
          parameters: _i1.testObjectToJson({
            'limit': limit,
            'userId': userId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i33.AuditTrail>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i33.AuditTrail>> getAuditTrail(
    _i1.TestSessionBuilder sessionBuilder, {
    String? entityType,
    String? entityId,
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'audit',
            method: 'getAuditTrail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'audit',
          methodName: 'getAuditTrail',
          parameters: _i1.testObjectToJson({
            'entityType': entityType,
            'entityId': entityId,
            'userId': userId,
            'from': from,
            'to': to,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i33.AuditTrail>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i33.AuditTrail>> getConfigChangeLog(
    _i1.TestSessionBuilder sessionBuilder, {
    String? entityType,
    required int limit,
    DateTime? from,
    DateTime? to,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'audit',
            method: 'getConfigChangeLog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'audit',
          methodName: 'getConfigChangeLog',
          parameters: _i1.testObjectToJson({
            'entityType': entityType,
            'limit': limit,
            'from': from,
            'to': to,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i33.AuditTrail>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i34.AccessLog>> getAccessLogs(
    _i1.TestSessionBuilder sessionBuilder, {
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'audit',
            method: 'getAccessLogs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'audit',
          methodName: 'getAccessLogs',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'from': from,
            'to': to,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i34.AccessLog>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> exportAuditCsv(
    _i1.TestSessionBuilder sessionBuilder, {
    String? entityType,
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'audit',
            method: 'exportAuditCsv',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'audit',
          methodName: 'exportAuditCsv',
          parameters: _i1.testObjectToJson({
            'entityType': entityType,
            'userId': userId,
            'from': from,
            'to': to,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AuditFeedEndpoint {
  _AuditFeedEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i33.AuditTrail>> getRecentAuditEvents(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'auditFeed',
            method: 'getRecentAuditEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auditFeed',
          methodName: 'getRecentAuditEvents',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i33.AuditTrail>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AuditTrailEndpoint {
  _AuditTrailEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<void> logAction(
    _i1.TestSessionBuilder sessionBuilder, {
    required String action,
    required String entityType,
    required String entityId,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
    String? ipAddress,
    String? rowHash,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'auditTrail',
            method: 'logAction',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auditTrail',
          methodName: 'logAction',
          parameters: _i1.testObjectToJson({
            'action': action,
            'entityType': entityType,
            'entityId': entityId,
            'oldValueJson': oldValueJson,
            'newValueJson': newValueJson,
            'reason': reason,
            'ipAddress': ipAddress,
            'rowHash': rowHash,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BatchAnnouncementEndpoint {
  _BatchAnnouncementEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i35.BatchAnnouncement>> listForBatch(
    _i1.TestSessionBuilder sessionBuilder,
    int batchId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'batchAnnouncement',
            method: 'listForBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'batchAnnouncement',
          methodName: 'listForBatch',
          parameters: _i1.testObjectToJson({'batchId': batchId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i35.BatchAnnouncement>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.BatchAnnouncement?> createForBatch(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    required String title,
    required String body,
    required String kind,
    int? relatedLiveClassId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'batchAnnouncement',
            method: 'createForBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'batchAnnouncement',
          methodName: 'createForBatch',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'title': title,
            'body': body,
            'kind': kind,
            'relatedLiveClassId': relatedLiveClassId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i35.BatchAnnouncement?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CertificateEndpoint {
  _CertificateEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i21.Certificate>> listCertificates(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    String? status,
    int? userId,
    int? courseVersionId,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'listCertificates',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'listCertificates',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'status': status,
            'userId': userId,
            'courseVersionId': courseVersionId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.Certificate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i21.Certificate?> getCertificate(
    _i1.TestSessionBuilder sessionBuilder,
    int certificateId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'getCertificate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'getCertificate',
          parameters: _i1.testObjectToJson({'certificateId': certificateId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i21.Certificate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i21.Certificate>> getUserCertificates(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'getUserCertificates',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'getUserCertificates',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.Certificate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i21.Certificate?> revokeCertificate(
    _i1.TestSessionBuilder sessionBuilder,
    int certificateId, {
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'revokeCertificate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'revokeCertificate',
          parameters: _i1.testObjectToJson({
            'certificateId': certificateId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i21.Certificate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, int>> getCertificateStats(
    _i1.TestSessionBuilder sessionBuilder,
    int organizationId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'getCertificateStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'getCertificateStats',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i21.Certificate?> verifyCertificate(
    _i1.TestSessionBuilder sessionBuilder,
    String qrCode,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'verifyCertificate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'verifyCertificate',
          parameters: _i1.testObjectToJson({'qrCode': qrCode}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i21.Certificate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i21.Certificate?> issueCertificate(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int courseVersionId,
    DateTime? expiresAt,
    int? templateId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'issueCertificate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'issueCertificate',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'courseVersionId': courseVersionId,
            'expiresAt': expiresAt,
            'templateId': templateId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i21.Certificate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i21.Certificate>> generateBatchCertificates(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    int? templateId,
    DateTime? expiresAt,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'generateBatchCertificates',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'generateBatchCertificates',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'templateId': templateId,
            'expiresAt': expiresAt,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.Certificate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> renderCertificateHtml(
    _i1.TestSessionBuilder sessionBuilder, {
    required int certificateId,
    int? templateId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'renderCertificateHtml',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'renderCertificateHtml',
          parameters: _i1.testObjectToJson({
            'certificateId': certificateId,
            'templateId': templateId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CertificateTemplateEndpoint {
  _CertificateTemplateEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i36.CertificateTemplate>> listTemplates(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificateTemplate',
            method: 'listTemplates',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificateTemplate',
          methodName: 'listTemplates',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i36.CertificateTemplate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i36.CertificateTemplate?> getTemplate(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificateTemplate',
            method: 'getTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificateTemplate',
          methodName: 'getTemplate',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i36.CertificateTemplate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i36.CertificateTemplate> createTemplate(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    required String name,
    required String htmlTemplate,
    required bool isDefault,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificateTemplate',
            method: 'createTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificateTemplate',
          methodName: 'createTemplate',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'name': name,
            'htmlTemplate': htmlTemplate,
            'isDefault': isDefault,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i36.CertificateTemplate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i36.CertificateTemplate> updateTemplate(
    _i1.TestSessionBuilder sessionBuilder, {
    required int templateId,
    String? name,
    String? htmlTemplate,
    bool? isDefault,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificateTemplate',
            method: 'updateTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificateTemplate',
          methodName: 'updateTemplate',
          parameters: _i1.testObjectToJson({
            'templateId': templateId,
            'name': name,
            'htmlTemplate': htmlTemplate,
            'isDefault': isDefault,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i36.CertificateTemplate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteTemplate(
    _i1.TestSessionBuilder sessionBuilder,
    int templateId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificateTemplate',
            method: 'deleteTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificateTemplate',
          methodName: 'deleteTemplate',
          parameters: _i1.testObjectToJson({'templateId': templateId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> previewTemplate(
    _i1.TestSessionBuilder sessionBuilder, {
    required String htmlTemplate,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificateTemplate',
            method: 'previewTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificateTemplate',
          methodName: 'previewTemplate',
          parameters: _i1.testObjectToJson({'htmlTemplate': htmlTemplate}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ComplianceEndpoint {
  _ComplianceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i37.ComplianceMetrics> getDepartmentCompliance(
    _i1.TestSessionBuilder sessionBuilder,
    int departmentId, {
    DateTime? asOf,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'compliance',
            method: 'getDepartmentCompliance',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'compliance',
          methodName: 'getDepartmentCompliance',
          parameters: _i1.testObjectToJson({
            'departmentId': departmentId,
            'asOf': asOf,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i37.ComplianceMetrics>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i38.UserComplianceMetrics> getUserCompliance(
    _i1.TestSessionBuilder sessionBuilder,
    int userId, {
    DateTime? asOf,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'compliance',
            method: 'getUserCompliance',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'compliance',
          methodName: 'getUserCompliance',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'asOf': asOf,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i38.UserComplianceMetrics>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isDepartmentBelowThreshold(
    _i1.TestSessionBuilder sessionBuilder, {
    required int departmentId,
    required double threshold,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'compliance',
            method: 'isDepartmentBelowThreshold',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'compliance',
          methodName: 'isDepartmentBelowThreshold',
          parameters: _i1.testObjectToJson({
            'departmentId': departmentId,
            'threshold': threshold,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> getEsignatureSummaryForUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'compliance',
            method: 'getEsignatureSummaryForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'compliance',
          methodName: 'getEsignatureSummaryForUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CourseBuilderEndpoint {
  _CourseBuilderEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i39.Module> createModule(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required String title,
    required int orderIndex,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'createModule',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'createModule',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'title': title,
            'orderIndex': orderIndex,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i39.Module>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i39.Module> updateModule(
    _i1.TestSessionBuilder sessionBuilder, {
    required int moduleId,
    String? title,
    int? orderIndex,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'updateModule',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'updateModule',
          parameters: _i1.testObjectToJson({
            'moduleId': moduleId,
            'title': title,
            'orderIndex': orderIndex,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i39.Module>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i40.Lesson> createLesson(
    _i1.TestSessionBuilder sessionBuilder, {
    required int moduleId,
    required String title,
    required int materialId,
    required int orderIndex,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'createLesson',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'createLesson',
          parameters: _i1.testObjectToJson({
            'moduleId': moduleId,
            'title': title,
            'materialId': materialId,
            'orderIndex': orderIndex,
            'durationMinutes': durationMinutes,
            'lessonType': lessonType,
            'minEngagementMinutes': minEngagementMinutes,
            'prerequisiteMode': prerequisiteMode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i40.Lesson>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i40.Lesson> updateLesson(
    _i1.TestSessionBuilder sessionBuilder, {
    required int lessonId,
    String? title,
    int? materialId,
    int? orderIndex,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'updateLesson',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'updateLesson',
          parameters: _i1.testObjectToJson({
            'lessonId': lessonId,
            'title': title,
            'materialId': materialId,
            'orderIndex': orderIndex,
            'durationMinutes': durationMinutes,
            'lessonType': lessonType,
            'minEngagementMinutes': minEngagementMinutes,
            'prerequisiteMode': prerequisiteMode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i40.Lesson>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.CourseVersion> createCourseVersion(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseId,
    required String version,
    required String status,
    String? changeSummary,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'createCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'createCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseId': courseId,
            'version': version,
            'status': status,
            'changeSummary': changeSummary,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.CourseVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> createNewVersionFromExisting(
    _i1.TestSessionBuilder sessionBuilder, {
    required int existingVersionId,
    required String changeSummary,
    required bool isMajorVersion,
    int? createdById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'createNewVersionFromExisting',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'createNewVersionFromExisting',
          parameters: _i1.testObjectToJson({
            'existingVersionId': existingVersionId,
            'changeSummary': changeSummary,
            'isMajorVersion': isMajorVersion,
            'createdById': createdById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.CourseVersion> updateCourseVersionStatus(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required String status,
    int? approverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'updateCourseVersionStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'updateCourseVersionStatus',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'status': status,
            'approverId': approverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.CourseVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i42.QaValidationResult> validateForQaSubmission(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'validateForQaSubmission',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'validateForQaSubmission',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i42.QaValidationResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.CourseVersion> submitForQaReview(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    int? submittedById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'submitForQaReview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'submitForQaReview',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'submittedById': submittedById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.CourseVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteModule(
    _i1.TestSessionBuilder sessionBuilder, {
    required int moduleId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'deleteModule',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'deleteModule',
          parameters: _i1.testObjectToJson({'moduleId': moduleId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteLesson(
    _i1.TestSessionBuilder sessionBuilder, {
    required int lessonId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'deleteLesson',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'deleteLesson',
          parameters: _i1.testObjectToJson({'lessonId': lessonId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i40.Lesson> updateLessonMaterial(
    _i1.TestSessionBuilder sessionBuilder, {
    required int lessonId,
    required int materialId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'updateLessonMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'updateLessonMaterial',
          parameters: _i1.testObjectToJson({
            'lessonId': lessonId,
            'materialId': materialId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i40.Lesson>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> saveDraft(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required List<Map<String, dynamic>> modules,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'courseBuilder',
            method: 'saveDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'courseBuilder',
          methodName: 'saveDraft',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'modules': modules,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CourseEndpoint {
  _CourseEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i43.Course>> listCourses(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
    String? status,
    String? search,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'listCourses',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'listCourses',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'status': status,
            'search': search,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i43.Course>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i43.Course>> listTrainerPublishedCoursesForAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    String? search,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'listTrainerPublishedCoursesForAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'listTrainerPublishedCoursesForAssignment',
          parameters: _i1.testObjectToJson({'search': search}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i43.Course>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i43.Course?> getCourse(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'getCourse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'getCourse',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i43.Course?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i41.CourseVersion>> getCourseVersions(
    _i1.TestSessionBuilder sessionBuilder,
    int courseId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'getCourseVersions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'getCourseVersions',
          parameters: _i1.testObjectToJson({'courseId': courseId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i41.CourseVersion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.CourseVersion?> getCourseVersion(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'getCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'getCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.CourseVersion?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i43.Course> createCourse(
    _i1.TestSessionBuilder sessionBuilder, {
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'createCourse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'createCourse',
          parameters: _i1.testObjectToJson({
            'title': title,
            'organizationId': organizationId,
            'sopNumber': sopNumber,
            'description': description,
            'createdById': createdById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i43.Course>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> createCourseWithVersion(
    _i1.TestSessionBuilder sessionBuilder, {
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
    String? previewVideoUrl,
    String? imageUrl,
    String? tags,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'createCourseWithVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'createCourseWithVersion',
          parameters: _i1.testObjectToJson({
            'title': title,
            'organizationId': organizationId,
            'sopNumber': sopNumber,
            'description': description,
            'createdById': createdById,
            'previewVideoUrl': previewVideoUrl,
            'imageUrl': imageUrl,
            'tags': tags,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i39.Module>> getModulesForCourseVersion(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'getModulesForCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'getModulesForCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i39.Module>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i40.Lesson>> getLessonsForModule(
    _i1.TestSessionBuilder sessionBuilder,
    int moduleId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'getLessonsForModule',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'getLessonsForModule',
          parameters: _i1.testObjectToJson({'moduleId': moduleId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i40.Lesson>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i40.Lesson?> getLessonWithMaterial(
    _i1.TestSessionBuilder sessionBuilder,
    int lessonId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'getLessonWithMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'getLessonWithMaterial',
          parameters: _i1.testObjectToJson({'lessonId': lessonId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i40.Lesson?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i43.Course>> searchCourses(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'searchCourses',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'searchCourses',
          parameters: _i1.testObjectToJson({
            'query': query,
            'organizationId': organizationId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i43.Course>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i43.Course> updateCourse(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'updateCourse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'updateCourse',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i43.Course>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteCourse(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'course',
            method: 'deleteCourse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'course',
          methodName: 'deleteCourse',
          parameters: _i1.testObjectToJson({'courseId': courseId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DocumentEndpoint {
  _DocumentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i44.Document>> listDocuments(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
    String? documentType,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'listDocuments',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'listDocuments',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'documentType': documentType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i44.Document>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i44.Document?> getDocument(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'getDocument',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'getDocument',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i44.Document?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i44.Document> updateDocumentQaClassification(
    _i1.TestSessionBuilder sessionBuilder, {
    required int documentId,
    required String trainingRequiredByQa,
    String? affectedDepartmentIdsJson,
    String? affectedRoleIdsJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'updateDocumentQaClassification',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'updateDocumentQaClassification',
          parameters: _i1.testObjectToJson({
            'documentId': documentId,
            'trainingRequiredByQa': trainingRequiredByQa,
            'affectedDepartmentIdsJson': affectedDepartmentIdsJson,
            'affectedRoleIdsJson': affectedRoleIdsJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i44.Document>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i45.DocumentVersion>> getDocumentVersions(
    _i1.TestSessionBuilder sessionBuilder,
    int documentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'getDocumentVersions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'getDocumentVersions',
          parameters: _i1.testObjectToJson({'documentId': documentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i45.DocumentVersion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i44.Document> createDocument(
    _i1.TestSessionBuilder sessionBuilder, {
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'createDocument',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'createDocument',
          parameters: _i1.testObjectToJson({
            'title': title,
            'documentNumber': documentNumber,
            'documentType': documentType,
            'organizationId': organizationId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i44.Document>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i45.DocumentVersion> createDocumentVersion(
    _i1.TestSessionBuilder sessionBuilder, {
    required int documentId,
    required String version,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    int? versionMajor,
    int? versionMinor,
    bool? isMajorVersion,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'createDocumentVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'createDocumentVersion',
          parameters: _i1.testObjectToJson({
            'documentId': documentId,
            'version': version,
            'storageKey': storageKey,
            'effectiveDate': effectiveDate,
            'obsoleteDate': obsoleteDate,
            'versionMajor': versionMajor,
            'versionMinor': versionMinor,
            'isMajorVersion': isMajorVersion,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i45.DocumentVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i46.DocumentLifecycle>> getDocumentLifecycle(
    _i1.TestSessionBuilder sessionBuilder,
    int documentVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'getDocumentLifecycle',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'getDocumentLifecycle',
          parameters: _i1.testObjectToJson({
            'documentVersionId': documentVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i46.DocumentLifecycle>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i46.DocumentLifecycle> transitionDocumentLifecycle(
    _i1.TestSessionBuilder sessionBuilder, {
    required int documentVersionId,
    required String newState,
    String? obsoleteReason,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? ipAddress,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'transitionDocumentLifecycle',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'transitionDocumentLifecycle',
          parameters: _i1.testObjectToJson({
            'documentVersionId': documentVersionId,
            'newState': newState,
            'obsoleteReason': obsoleteReason,
            'userId': userId,
            'signatureMeaning': signatureMeaning,
            'passwordPlaintext': passwordPlaintext,
            'ipAddress': ipAddress,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i46.DocumentLifecycle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i47.ApprovalWorkflow> createApprovalStep(
    _i1.TestSessionBuilder sessionBuilder, {
    required int documentVersionId,
    required int step,
    required int approverId,
    required String status,
    int? esignatureId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'createApprovalStep',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'createApprovalStep',
          parameters: _i1.testObjectToJson({
            'documentVersionId': documentVersionId,
            'step': step,
            'approverId': approverId,
            'status': status,
            'esignatureId': esignatureId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i47.ApprovalWorkflow>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _EventEndpoint {
  _EventEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<void> triggerSopUpdated(
    _i1.TestSessionBuilder sessionBuilder, {
    required String documentId,
    required String courseVersionId,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'triggerSopUpdated',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'triggerSopUpdated',
          parameters: _i1.testObjectToJson({
            'documentId': documentId,
            'courseVersionId': courseVersionId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> triggerEmployeeCreated(
    _i1.TestSessionBuilder sessionBuilder, {
    required String userId,
    required String departmentId,
    required String roleId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'triggerEmployeeCreated',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'triggerEmployeeCreated',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'departmentId': departmentId,
            'roleId': roleId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> triggerEmployeeTransferred(
    _i1.TestSessionBuilder sessionBuilder, {
    required String userId,
    required String oldDepartmentId,
    required String newDepartmentId,
    required String oldRoleId,
    required String newRoleId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'triggerEmployeeTransferred',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'triggerEmployeeTransferred',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'oldDepartmentId': oldDepartmentId,
            'newDepartmentId': newDepartmentId,
            'oldRoleId': oldRoleId,
            'newRoleId': newRoleId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> triggerCapaTrainingComplete(
    _i1.TestSessionBuilder sessionBuilder, {
    required int capaId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'triggerCapaTrainingComplete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'triggerCapaTrainingComplete',
          parameters: _i1.testObjectToJson({'capaId': capaId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> triggerComplianceDropAlert(
    _i1.TestSessionBuilder sessionBuilder, {
    required double threshold,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'triggerComplianceDropAlert',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'triggerComplianceDropAlert',
          parameters: _i1.testObjectToJson({'threshold': threshold}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> triggerNewCourseRelease(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'triggerNewCourseRelease',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'triggerNewCourseRelease',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _InspectionEndpoint {
  _InspectionEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i48.InspectionRecord>> listInspectionRecords(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'listInspectionRecords',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'listInspectionRecords',
          parameters: _i1.testObjectToJson({'limit': limit}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i48.InspectionRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> createInspectionRecord(
    _i1.TestSessionBuilder sessionBuilder, {
    required String inspectionType,
    required int siteId,
    String? scopeDescription,
    DateTime? scheduledDate,
    String? inspectorNames,
    required int tokenHoursValid,
    int? createdById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'createInspectionRecord',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'createInspectionRecord',
          parameters: _i1.testObjectToJson({
            'inspectionType': inspectionType,
            'siteId': siteId,
            'scopeDescription': scopeDescription,
            'scheduledDate': scheduledDate,
            'inspectorNames': inspectorNames,
            'tokenHoursValid': tokenHoursValid,
            'createdById': createdById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>?> validateAuditorToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required String token,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'validateAuditorToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'validateAuditorToken',
          parameters: _i1.testObjectToJson({'token': token}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i49.AuditorPageLog>> listAuditorPageLogs(
    _i1.TestSessionBuilder sessionBuilder, {
    required int inspectionRecordId,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'listAuditorPageLogs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'listAuditorPageLogs',
          parameters: _i1.testObjectToJson({
            'inspectionRecordId': inspectionRecordId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i49.AuditorPageLog>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> logAuditorPageView(
    _i1.TestSessionBuilder sessionBuilder, {
    required int inspectionRecordId,
    required String pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    int? timeOnPageSeconds,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'logAuditorPageView',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'logAuditorPageView',
          parameters: _i1.testObjectToJson({
            'inspectionRecordId': inspectionRecordId,
            'pageUrl': pageUrl,
            'pageTitle': pageTitle,
            'entityType': entityType,
            'entityId': entityId,
            'timeOnPageSeconds': timeOnPageSeconds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i50.InspectionPackage>> listInspectionPackages(
    _i1.TestSessionBuilder sessionBuilder, {
    required int inspectionRecordId,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'listInspectionPackages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'listInspectionPackages',
          parameters: _i1.testObjectToJson({
            'inspectionRecordId': inspectionRecordId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i50.InspectionPackage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> generateEvidencePackageForAuditor(
    _i1.TestSessionBuilder sessionBuilder, {
    required String token,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'generateEvidencePackageForAuditor',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'generateEvidencePackageForAuditor',
          parameters: _i1.testObjectToJson({'token': token}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> generateInspectionPackage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int inspectionRecordId,
    required int generatedById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'generateInspectionPackage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'generateInspectionPackage',
          parameters: _i1.testObjectToJson({
            'inspectionRecordId': inspectionRecordId,
            'generatedById': generatedById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i50.InspectionPackage> signInspectionPackageAsOfficial(
    _i1.TestSessionBuilder sessionBuilder, {
    required int packageId,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? ipAddress,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'signInspectionPackageAsOfficial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'signInspectionPackageAsOfficial',
          parameters: _i1.testObjectToJson({
            'packageId': packageId,
            'userId': userId,
            'signatureMeaning': signatureMeaning,
            'passwordPlaintext': passwordPlaintext,
            'ipAddress': ipAddress,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i50.InspectionPackage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> searchEmployeesForAudit(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    int? inspectionRecordId,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'searchEmployeesForAudit',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'searchEmployeesForAudit',
          parameters: _i1.testObjectToJson({
            'query': query,
            'inspectionRecordId': inspectionRecordId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getSopTrainingCoverage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int sopDocumentId,
    required int versionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'inspection',
            method: 'getSopTrainingCoverage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'inspection',
          methodName: 'getSopTrainingCoverage',
          parameters: _i1.testObjectToJson({
            'sopDocumentId': sopDocumentId,
            'versionId': versionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _LearnerSupportEndpoint {
  _LearnerSupportEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i51.LearnerTrainerMessage>> listThread(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId, {
    int? limit,
    int? offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'learnerSupport',
            method: 'listThread',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learnerSupport',
          methodName: 'listThread',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i51.LearnerTrainerMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i51.LearnerTrainerMessage?> sendMessage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required String body,
    int? parentMessageId,
    int? toUserId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'learnerSupport',
            method: 'sendMessage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learnerSupport',
          methodName: 'sendMessage',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'body': body,
            'parentMessageId': parentMessageId,
            'toUserId': toUserId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i51.LearnerTrainerMessage?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i52.LearnerSupportThreadSummary>> listTrainerSupportThreads(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'learnerSupport',
            method: 'listTrainerSupportThreads',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learnerSupport',
          methodName: 'listTrainerSupportThreads',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i52.LearnerSupportThreadSummary>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> markThreadMessagesRead(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'learnerSupport',
            method: 'markThreadMessagesRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learnerSupport',
          methodName: 'markThreadMessagesRead',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _LessonBlockEndpoint {
  _LessonBlockEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i53.LessonBlock>> listBlocks(
    _i1.TestSessionBuilder sessionBuilder, {
    required int lessonId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'lessonBlock',
            method: 'listBlocks',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'lessonBlock',
          methodName: 'listBlocks',
          parameters: _i1.testObjectToJson({'lessonId': lessonId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i53.LessonBlock>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i53.LessonBlock> createBlock(
    _i1.TestSessionBuilder sessionBuilder, {
    required int lessonId,
    required String blockType,
    required String contentJson,
    required int orderIndex,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'lessonBlock',
            method: 'createBlock',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'lessonBlock',
          methodName: 'createBlock',
          parameters: _i1.testObjectToJson({
            'lessonId': lessonId,
            'blockType': blockType,
            'contentJson': contentJson,
            'orderIndex': orderIndex,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i53.LessonBlock>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i53.LessonBlock> updateBlock(
    _i1.TestSessionBuilder sessionBuilder, {
    required int blockId,
    String? contentJson,
    int? orderIndex,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'lessonBlock',
            method: 'updateBlock',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'lessonBlock',
          methodName: 'updateBlock',
          parameters: _i1.testObjectToJson({
            'blockId': blockId,
            'contentJson': contentJson,
            'orderIndex': orderIndex,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i53.LessonBlock>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteBlock(
    _i1.TestSessionBuilder sessionBuilder, {
    required int blockId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'lessonBlock',
            method: 'deleteBlock',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'lessonBlock',
          methodName: 'deleteBlock',
          parameters: _i1.testObjectToJson({'blockId': blockId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> reorderBlocks(
    _i1.TestSessionBuilder sessionBuilder, {
    required int lessonId,
    required List<int> blockIds,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'lessonBlock',
            method: 'reorderBlocks',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'lessonBlock',
          methodName: 'reorderBlocks',
          parameters: _i1.testObjectToJson({
            'lessonId': lessonId,
            'blockIds': blockIds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _LiveClassEndpoint {
  _LiveClassEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i54.LiveClass?> create(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    required String title,
    String? description,
    required DateTime scheduledAt,
    required int durationMinutes,
    String? meetingUrl,
    required bool autoRecording,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'liveClass',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'liveClass',
          methodName: 'create',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'title': title,
            'description': description,
            'scheduledAt': scheduledAt,
            'durationMinutes': durationMinutes,
            'meetingUrl': meetingUrl,
            'autoRecording': autoRecording,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i54.LiveClass?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i54.LiveClass>> listByBatch(
    _i1.TestSessionBuilder sessionBuilder,
    int batchId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'liveClass',
            method: 'listByBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'liveClass',
          methodName: 'listByBatch',
          parameters: _i1.testObjectToJson({'batchId': batchId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i54.LiveClass>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i54.LiveClass?> update(
    _i1.TestSessionBuilder sessionBuilder, {
    required int liveClassId,
    String? title,
    String? description,
    DateTime? scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'liveClass',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'liveClass',
          methodName: 'update',
          parameters: _i1.testObjectToJson({
            'liveClassId': liveClassId,
            'title': title,
            'description': description,
            'scheduledAt': scheduledAt,
            'durationMinutes': durationMinutes,
            'meetingUrl': meetingUrl,
            'autoRecording': autoRecording,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i54.LiveClass?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> delete(
    _i1.TestSessionBuilder sessionBuilder,
    int liveClassId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'liveClass',
            method: 'delete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'liveClass',
          methodName: 'delete',
          parameters: _i1.testObjectToJson({'liveClassId': liveClassId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _MaterialEndpoint {
  _MaterialEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i55.Material?> getMaterial(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'getMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'getMaterial',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i55.Material?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String?> getMaterialViewUrl(
    _i1.TestSessionBuilder sessionBuilder,
    String storageKey,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'getMaterialViewUrl',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'getMaterialViewUrl',
          parameters: _i1.testObjectToJson({'storageKey': storageKey}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i55.Material> createMaterial(
    _i1.TestSessionBuilder sessionBuilder, {
    required String title,
    required String materialType,
    required int organizationId,
    String? contentUrl,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'createMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'createMaterial',
          parameters: _i1.testObjectToJson({
            'title': title,
            'materialType': materialType,
            'organizationId': organizationId,
            'contentUrl': contentUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i55.Material>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String?> getMaterialContentUrl(
    _i1.TestSessionBuilder sessionBuilder,
    int materialId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'getMaterialContentUrl',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'getMaterialContentUrl',
          parameters: _i1.testObjectToJson({'materialId': materialId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String?> getUploadDescription(
    _i1.TestSessionBuilder sessionBuilder,
    String path,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'getUploadDescription',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'getUploadDescription',
          parameters: _i1.testObjectToJson({'path': path}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> verifyUpload(
    _i1.TestSessionBuilder sessionBuilder,
    String path,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'verifyUpload',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'verifyUpload',
          parameters: _i1.testObjectToJson({'path': path}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i56.MaterialVersion> createMaterialVersion(
    _i1.TestSessionBuilder sessionBuilder, {
    required int materialId,
    required String storageKey,
    String? fileHash,
    int? fileSizeBytes,
    String? changeSummary,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'createMaterialVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'createMaterialVersion',
          parameters: _i1.testObjectToJson({
            'materialId': materialId,
            'storageKey': storageKey,
            'fileHash': fileHash,
            'fileSizeBytes': fileSizeBytes,
            'changeSummary': changeSummary,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i56.MaterialVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i55.Material> updateMaterial(
    _i1.TestSessionBuilder sessionBuilder, {
    required int materialId,
    String? title,
    String? materialType,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'updateMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'updateMaterial',
          parameters: _i1.testObjectToJson({
            'materialId': materialId,
            'title': title,
            'materialType': materialType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i55.Material>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i56.MaterialVersion?> getLatestMaterialVersion(
    _i1.TestSessionBuilder sessionBuilder,
    int materialId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'getLatestMaterialVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'getLatestMaterialVersion',
          parameters: _i1.testObjectToJson({'materialId': materialId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i56.MaterialVersion?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i56.MaterialVersion> updateVirusScanStatus(
    _i1.TestSessionBuilder sessionBuilder, {
    required int materialVersionId,
    required String virusScanStatus,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'updateVirusScanStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'updateVirusScanStatus',
          parameters: _i1.testObjectToJson({
            'materialVersionId': materialVersionId,
            'virusScanStatus': virusScanStatus,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i56.MaterialVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i56.MaterialVersion>> getMaterialVersions(
    _i1.TestSessionBuilder sessionBuilder,
    int materialId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'getMaterialVersions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'getMaterialVersions',
          parameters: _i1.testObjectToJson({'materialId': materialId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i56.MaterialVersion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i55.Material>> listMaterials(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'listMaterials',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'listMaterials',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i55.Material>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i57.MaterialProgress> updateProgress(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'updateProgress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'updateProgress',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i57.MaterialProgress>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i57.MaterialProgress?> getProgress(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int materialId,
    int? enrollmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'getProgress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'getProgress',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'materialId': materialId,
            'enrollmentId': enrollmentId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i57.MaterialProgress?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i57.MaterialProgress> recordEngagement(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int materialId,
    required int lessonId,
    int? enrollmentId,
    required bool tabFocused,
    int? scrollDepthPct,
    int? videoWatchedPct,
    int? videoPositionSeconds,
    required int deltaSeconds,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'recordEngagement',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'recordEngagement',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'materialId': materialId,
            'lessonId': lessonId,
            'enrollmentId': enrollmentId,
            'tabFocused': tabFocused,
            'scrollDepthPct': scrollDepthPct,
            'videoWatchedPct': videoWatchedPct,
            'videoPositionSeconds': videoPositionSeconds,
            'deltaSeconds': deltaSeconds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i57.MaterialProgress>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteMaterial(
    _i1.TestSessionBuilder sessionBuilder, {
    required int materialId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'deleteMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'deleteMaterial',
          parameters: _i1.testObjectToJson({'materialId': materialId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getMaterialWithVersions(
    _i1.TestSessionBuilder sessionBuilder, {
    required int materialId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'material',
            method: 'getMaterialWithVersions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'material',
          methodName: 'getMaterialWithVersions',
          parameters: _i1.testObjectToJson({'materialId': materialId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _MessagingEndpoint {
  _MessagingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i58.MessagingUnreadCounts> getUnreadCounts(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getUnreadCounts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getUnreadCounts',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i58.MessagingUnreadCounts>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i51.LearnerTrainerMessage>> getThreadMessages(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getThreadMessages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getThreadMessages',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i51.LearnerTrainerMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i52.LearnerSupportThreadSummary>> getTrainerInbox(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getTrainerInbox',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getTrainerInbox',
          parameters: _i1.testObjectToJson({
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i52.LearnerSupportThreadSummary>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i52.LearnerSupportThreadSummary>> getLearnerInbox(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getLearnerInbox',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getLearnerInbox',
          parameters: _i1.testObjectToJson({
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i52.LearnerSupportThreadSummary>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i59.SmeThreadSummary>> getQaInbox(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getQaInbox',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getQaInbox',
          parameters: _i1.testObjectToJson({
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i59.SmeThreadSummary>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i59.SmeThreadSummary>> getQaReviewerInbox(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getQaReviewerInbox',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getQaReviewerInbox',
          parameters: _i1.testObjectToJson({
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i59.SmeThreadSummary>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i60.SmeReviewComment>> getQaThreadComments(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getQaThreadComments',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getQaThreadComments',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i60.SmeReviewComment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> markQaThreadRead(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'markQaThreadRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'markQaThreadRead',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> markLearnerThreadRead(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'markLearnerThreadRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'markLearnerThreadRead',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getUnreadNotificationCount(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getUnreadNotificationCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getUnreadNotificationCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i61.Notification>> getNotifications(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getNotifications',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getNotifications',
          parameters: _i1.testObjectToJson({
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i61.Notification>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> markAllNotificationsRead(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'markAllNotificationsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'markAllNotificationsRead',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _MfaEndpoint {
  _MfaEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i62.MfaStatusResult> getMfaStatus(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mfa',
            method: 'getMfaStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mfa',
          methodName: 'getMfaStatus',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i62.MfaStatusResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i63.MfaEnrollResult> enrollMfa(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mfa',
            method: 'enrollMfa',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mfa',
          methodName: 'enrollMfa',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i63.MfaEnrollResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> verifyMfaEnrollment(
    _i1.TestSessionBuilder sessionBuilder,
    String code,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mfa',
            method: 'verifyMfaEnrollment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mfa',
          methodName: 'verifyMfaEnrollment',
          parameters: _i1.testObjectToJson({'code': code}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> verifyMfa(
    _i1.TestSessionBuilder sessionBuilder,
    String code,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mfa',
            method: 'verifyMfa',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mfa',
          methodName: 'verifyMfa',
          parameters: _i1.testObjectToJson({'code': code}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> disableMfa(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mfa',
            method: 'disableMfa',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mfa',
          methodName: 'disableMfa',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isMfaVerified(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mfa',
            method: 'isMfaVerified',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mfa',
          methodName: 'isMfaVerified',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NotificationEndpoint {
  _NotificationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i61.Notification>> getUserNotifications(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getUserNotifications',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getUserNotifications',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i61.Notification>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i64.InAppNotification>> getInAppNotifications(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getInAppNotifications',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getInAppNotifications',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i64.InAppNotification>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i64.InAppNotification>> getTrainerNotifications(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getTrainerNotifications',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getTrainerNotifications',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i64.InAppNotification>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> markNotificationRead(
    _i1.TestSessionBuilder sessionBuilder, {
    required int notificationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'markNotificationRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'markNotificationRead',
          parameters: _i1.testObjectToJson({'notificationId': notificationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getUnreadCount(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getUnreadCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getUnreadCount',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i61.Notification>> listNotifications(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    String? type,
    String? channel,
    String? deliveryStatus,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'listNotifications',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'listNotifications',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'type': type,
            'channel': channel,
            'deliveryStatus': deliveryStatus,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i61.Notification>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> broadcastInAppToOrganization(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    required String message,
    required String type,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'broadcastInAppToOrganization',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'broadcastInAppToOrganization',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'message': message,
            'type': type,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NotificationTemplateEndpoint {
  _NotificationTemplateEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i65.NotificationTemplate>> listTemplates(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    String? status,
    String? type,
    String? channel,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationTemplate',
            method: 'listTemplates',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationTemplate',
          methodName: 'listTemplates',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'status': status,
            'type': type,
            'channel': channel,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i65.NotificationTemplate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i65.NotificationTemplate?> getTemplate(
    _i1.TestSessionBuilder sessionBuilder,
    int templateId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationTemplate',
            method: 'getTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationTemplate',
          methodName: 'getTemplate',
          parameters: _i1.testObjectToJson({'templateId': templateId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i65.NotificationTemplate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i65.NotificationTemplate?> createTemplate(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    required String name,
    required String type,
    required String channel,
    String? triggerEvent,
    String? subject,
    required String bodyTemplate,
    required String status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationTemplate',
            method: 'createTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationTemplate',
          methodName: 'createTemplate',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'name': name,
            'type': type,
            'channel': channel,
            'triggerEvent': triggerEvent,
            'subject': subject,
            'bodyTemplate': bodyTemplate,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i65.NotificationTemplate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i65.NotificationTemplate?> updateTemplate(
    _i1.TestSessionBuilder sessionBuilder,
    int templateId, {
    String? name,
    String? type,
    String? channel,
    String? triggerEvent,
    String? subject,
    String? bodyTemplate,
    String? status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationTemplate',
            method: 'updateTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationTemplate',
          methodName: 'updateTemplate',
          parameters: _i1.testObjectToJson({
            'templateId': templateId,
            'name': name,
            'type': type,
            'channel': channel,
            'triggerEvent': triggerEvent,
            'subject': subject,
            'bodyTemplate': bodyTemplate,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i65.NotificationTemplate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteTemplate(
    _i1.TestSessionBuilder sessionBuilder,
    int templateId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationTemplate',
            method: 'deleteTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationTemplate',
          methodName: 'deleteTemplate',
          parameters: _i1.testObjectToJson({'templateId': templateId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, int>> getTemplateStats(
    _i1.TestSessionBuilder sessionBuilder,
    int organizationId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationTemplate',
            method: 'getTemplateStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationTemplate',
          methodName: 'getTemplateStats',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i65.NotificationTemplate?> duplicateTemplate(
    _i1.TestSessionBuilder sessionBuilder,
    int templateId, {
    String? newName,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationTemplate',
            method: 'duplicateTemplate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationTemplate',
          methodName: 'duplicateTemplate',
          parameters: _i1.testObjectToJson({
            'templateId': templateId,
            'newName': newName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i65.NotificationTemplate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _OqEndpoint {
  _OqEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i66.PracticalChecklistItem?> createChecklistItem(
    _i1.TestSessionBuilder sessionBuilder, {
    required int competencyId,
    required String title,
    String? description,
    required int orderIndex,
    required bool isCritical,
    required int organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'createChecklistItem',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'createChecklistItem',
          parameters: _i1.testObjectToJson({
            'competencyId': competencyId,
            'title': title,
            'description': description,
            'orderIndex': orderIndex,
            'isCritical': isCritical,
            'organizationId': organizationId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i66.PracticalChecklistItem?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i66.PracticalChecklistItem>> listChecklistItems(
    _i1.TestSessionBuilder sessionBuilder, {
    required int competencyId,
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'listChecklistItems',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'listChecklistItems',
          parameters: _i1.testObjectToJson({
            'competencyId': competencyId,
            'organizationId': organizationId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i66.PracticalChecklistItem>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i66.PracticalChecklistItem?> updateChecklistItem(
    _i1.TestSessionBuilder sessionBuilder, {
    required int itemId,
    String? title,
    String? description,
    int? orderIndex,
    bool? isCritical,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'updateChecklistItem',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'updateChecklistItem',
          parameters: _i1.testObjectToJson({
            'itemId': itemId,
            'title': title,
            'description': description,
            'orderIndex': orderIndex,
            'isCritical': isCritical,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i66.PracticalChecklistItem?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteChecklistItem(
    _i1.TestSessionBuilder sessionBuilder,
    int itemId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'deleteChecklistItem',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'deleteChecklistItem',
          parameters: _i1.testObjectToJson({'itemId': itemId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i67.ObservationLog?> recordObservation(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int competencyId,
    required int checklistItemId,
    required String result,
    String? notes,
    required String evaluatorSignatureMeaning,
    String? evaluatorPasswordPlaintext,
    required int organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'recordObservation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'recordObservation',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'competencyId': competencyId,
            'checklistItemId': checklistItemId,
            'result': result,
            'notes': notes,
            'evaluatorSignatureMeaning': evaluatorSignatureMeaning,
            'evaluatorPasswordPlaintext': evaluatorPasswordPlaintext,
            'organizationId': organizationId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i67.ObservationLog?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i67.ObservationLog?> traineeCountersignObservation(
    _i1.TestSessionBuilder sessionBuilder, {
    required int observationLogId,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'traineeCountersignObservation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'traineeCountersignObservation',
          parameters: _i1.testObjectToJson({
            'observationLogId': observationLogId,
            'signatureMeaning': signatureMeaning,
            'passwordPlaintext': passwordPlaintext,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i67.ObservationLog?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i67.ObservationLog>> listObservationsForUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    int? competencyId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'listObservationsForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'listObservationsForUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'competencyId': competencyId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i67.ObservationLog>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getOqProgress(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int competencyId,
    required int organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'getOqProgress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'getOqProgress',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'competencyId': competencyId,
            'organizationId': organizationId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i68.UserCompetency?> qaVerifyAndAwardCompetency(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int competencyId,
    required int organizationId,
    required String qaSignatureMeaning,
    String? qaPasswordPlaintext,
    DateTime? expiresAt,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'qaVerifyAndAwardCompetency',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'qaVerifyAndAwardCompetency',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'competencyId': competencyId,
            'organizationId': organizationId,
            'qaSignatureMeaning': qaSignatureMeaning,
            'qaPasswordPlaintext': qaPasswordPlaintext,
            'expiresAt': expiresAt,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i68.UserCompetency?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i68.UserCompetency>> listUserCompetencies(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required bool activeOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'listUserCompetencies',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'listUserCompetencies',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'activeOnly': activeOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i68.UserCompetency>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isUserQualified(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int competencyId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'isUserQualified',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'isUserQualified',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'competencyId': competencyId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i69.Competency?> createCompetency(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    required String code,
    int? level,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'createCompetency',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'createCompetency',
          parameters: _i1.testObjectToJson({
            'name': name,
            'code': code,
            'level': level,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i69.Competency?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i69.Competency>> listCompetencies(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'oq',
            method: 'listCompetencies',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'oq',
          methodName: 'listCompetencies',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i69.Competency>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _OrganizationEndpoint {
  _OrganizationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i70.Organization>> listOrganizations(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'listOrganizations',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'listOrganizations',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i70.Organization>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i70.Organization?> getOrganization(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'getOrganization',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'getOrganization',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i70.Organization?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i70.Organization> createOrganization(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    required String code,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'createOrganization',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'createOrganization',
          parameters: _i1.testObjectToJson({
            'name': name,
            'code': code,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i70.Organization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i71.Site>> listSites(
    _i1.TestSessionBuilder sessionBuilder,
    int organizationId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'listSites',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'listSites',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i71.Site>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i72.Department>> listDepartments(
    _i1.TestSessionBuilder sessionBuilder,
    int siteId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'listDepartments',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'listDepartments',
          parameters: _i1.testObjectToJson({'siteId': siteId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i72.Department>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i12.JobRole>> listJobRoles(
    _i1.TestSessionBuilder sessionBuilder,
    int departmentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'listJobRoles',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'listJobRoles',
          parameters: _i1.testObjectToJson({'departmentId': departmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i12.JobRole>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i7.PharmaUser>> listUsers(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
    int? departmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'listUsers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'listUsers',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'departmentId': departmentId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i7.PharmaUser>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i70.Organization> updateOrganization(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    String? name,
    String? code,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'updateOrganization',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'updateOrganization',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'name': name,
            'code': code,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i70.Organization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i73.SystemConfiguration>> listOrganizationSettings(
    _i1.TestSessionBuilder sessionBuilder,
    int organizationId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'listOrganizationSettings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'listOrganizationSettings',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i73.SystemConfiguration>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i73.SystemConfiguration> upsertOrganizationSetting(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    required String key,
    required String value,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'organization',
            method: 'upsertOrganizationSetting',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'organization',
          methodName: 'upsertOrganizationSetting',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'key': key,
            'value': value,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i73.SystemConfiguration>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _QaEndpoint {
  _QaEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i41.CourseVersion>> listPendingCourseVersions(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qa',
            method: 'listPendingCourseVersions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qa',
          methodName: 'listPendingCourseVersions',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i41.CourseVersion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.CourseVersion> approveCourseVersion(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required String passwordPlaintext,
    required String signatureMeaning,
    int? approverId,
    String? reviewChecklistJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qa',
            method: 'approveCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qa',
          methodName: 'approveCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'passwordPlaintext': passwordPlaintext,
            'signatureMeaning': signatureMeaning,
            'approverId': approverId,
            'reviewChecklistJson': reviewChecklistJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.CourseVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.CourseVersion> rejectCourseVersion(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    String? reason,
    required bool returnForChanges,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qa',
            method: 'rejectCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qa',
          methodName: 'rejectCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'reason': reason,
            'returnForChanges': returnForChanges,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.CourseVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getPendingDocumentApprovalsCount(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qa',
            method: 'getPendingDocumentApprovalsCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qa',
          methodName: 'getPendingDocumentApprovalsCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.CourseVersion> returnCourseForChanges(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required String comments,
    int? reviewerId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qa',
            method: 'returnCourseForChanges',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qa',
          methodName: 'returnCourseForChanges',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'comments': comments,
            'reviewerId': reviewerId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.CourseVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i74.CourseReview>> getCourseReviews(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qa',
            method: 'getCourseReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qa',
          methodName: 'getCourseReviews',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i74.CourseReview>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i74.CourseReview>> getCourseReviewsForTrainer(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qa',
            method: 'getCourseReviewsForTrainer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qa',
          methodName: 'getCourseReviewsForTrainer',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i74.CourseReview>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _QualityEventEndpoint {
  _QualityEventEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i75.QualityEvent>> listQualityEvents(
    _i1.TestSessionBuilder sessionBuilder, {
    int? siteId,
    String? eventType,
    String? status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'listQualityEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'listQualityEvents',
          parameters: _i1.testObjectToJson({
            'siteId': siteId,
            'eventType': eventType,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i75.QualityEvent>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i75.QualityEvent?> getQualityEvent(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'getQualityEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'getQualityEvent',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i75.QualityEvent?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i22.Capa>> listCapas(
    _i1.TestSessionBuilder sessionBuilder, {
    int? qualityEventId,
    String? status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'listCapas',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'listCapas',
          parameters: _i1.testObjectToJson({
            'qualityEventId': qualityEventId,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i22.Capa>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i75.QualityEvent> createQualityEvent(
    _i1.TestSessionBuilder sessionBuilder, {
    required String eventType,
    required String title,
    required String status,
    String? referenceId,
    int? siteId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'createQualityEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'createQualityEvent',
          parameters: _i1.testObjectToJson({
            'eventType': eventType,
            'title': title,
            'status': status,
            'referenceId': referenceId,
            'siteId': siteId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i75.QualityEvent>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.Capa> updateCapaStatus(
    _i1.TestSessionBuilder sessionBuilder, {
    required int capaId,
    required String status,
    String? rootCause,
    DateTime? rcaCompletedAt,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'updateCapaStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'updateCapaStatus',
          parameters: _i1.testObjectToJson({
            'capaId': capaId,
            'status': status,
            'rootCause': rootCause,
            'rcaCompletedAt': rcaCompletedAt,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i22.Capa>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.Capa> closeCapa(
    _i1.TestSessionBuilder sessionBuilder, {
    required int capaId,
    required int closedById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'closeCapa',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'closeCapa',
          parameters: _i1.testObjectToJson({
            'capaId': capaId,
            'closedById': closedById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i22.Capa>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> closeCapaWithSignature(
    _i1.TestSessionBuilder sessionBuilder, {
    required int capaId,
    required String passwordPlaintext,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'closeCapaWithSignature',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'closeCapaWithSignature',
          parameters: _i1.testObjectToJson({
            'capaId': capaId,
            'passwordPlaintext': passwordPlaintext,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.Capa> createCapa(
    _i1.TestSessionBuilder sessionBuilder, {
    required int qualityEventId,
    String? description,
    String? rootCause,
    required bool trainingRequired,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'createCapa',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'createCapa',
          parameters: _i1.testObjectToJson({
            'qualityEventId': qualityEventId,
            'description': description,
            'rootCause': rootCause,
            'trainingRequired': trainingRequired,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i22.Capa>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.TrainingAssignment?> assignTrainingFromCapa(
    _i1.TestSessionBuilder sessionBuilder, {
    required int capaId,
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'assignTrainingFromCapa',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'assignTrainingFromCapa',
          parameters: _i1.testObjectToJson({
            'capaId': capaId,
            'userId': userId,
            'courseVersionId': courseVersionId,
            'assignedById': assignedById,
            'dueDate': dueDate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.TrainingAssignment?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i76.InspectionReport>> listInspectionReports(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
    int? siteId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'listInspectionReports',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'listInspectionReports',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'siteId': siteId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i76.InspectionReport>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i76.InspectionReport> createInspectionReport(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    required String status,
    int? siteId,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'qualityEvent',
            method: 'createInspectionReport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'qualityEvent',
          methodName: 'createInspectionReport',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'status': status,
            'siteId': siteId,
            'inspector': inspector,
            'inspectionDate': inspectionDate,
            'findingsJson': findingsJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i76.InspectionReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _RealtimeEndpoint {
  _RealtimeEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String> getConnectionToken(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'realtime',
            method: 'getConnectionToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'realtime',
          methodName: 'getConnectionToken',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SeedEndpoint {
  _SeedEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String> runSeed(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'seed',
            method: 'runSeed',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'seed',
          methodName: 'runSeed',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> runMvpSeed(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'seed',
            method: 'runMvpSeed',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'seed',
          methodName: 'runMvpSeed',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> clearAndReseed(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'seed',
            method: 'clearAndReseed',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'seed',
          methodName: 'clearAndReseed',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> runComprehensiveSeed(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'seed',
            method: 'runComprehensiveSeed',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'seed',
          methodName: 'runComprehensiveSeed',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> provisionAuthAccounts(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'seed',
            method: 'provisionAuthAccounts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'seed',
          methodName: 'provisionAuthAccounts',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> fixAdminPasswords(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'seed',
            method: 'fixAdminPasswords',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'seed',
          methodName: 'fixAdminPasswords',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SmeEndpoint {
  _SmeEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i77.SmeAssignment>> listAssignmentsForCourse(
    _i1.TestSessionBuilder sessionBuilder,
    int courseId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sme',
            method: 'listAssignmentsForCourse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sme',
          methodName: 'listAssignmentsForCourse',
          parameters: _i1.testObjectToJson({'courseId': courseId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i77.SmeAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i77.SmeAssignment> inviteSme(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseId,
    required int smeUserId,
    int? courseVersionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sme',
            method: 'inviteSme',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sme',
          methodName: 'inviteSme',
          parameters: _i1.testObjectToJson({
            'courseId': courseId,
            'smeUserId': smeUserId,
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i77.SmeAssignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i60.SmeReviewComment>> listCommentsForCourseVersion(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId, {
    int? limit,
    int? offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sme',
            method: 'listCommentsForCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sme',
          methodName: 'listCommentsForCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i60.SmeReviewComment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i60.SmeReviewComment> addComment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseVersionId,
    required String sectionRef,
    required String body,
    required String severity,
    int? parentCommentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sme',
            method: 'addComment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sme',
          methodName: 'addComment',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
            'sectionRef': sectionRef,
            'body': body,
            'severity': severity,
            'parentCommentId': parentCommentId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i60.SmeReviewComment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i60.SmeReviewComment> resolveComment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int commentId,
    String? trainerResponse,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sme',
            method: 'resolveComment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sme',
          methodName: 'resolveComment',
          parameters: _i1.testObjectToJson({
            'commentId': commentId,
            'trainerResponse': trainerResponse,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i60.SmeReviewComment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> markCommentsRead(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sme',
            method: 'markCommentsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sme',
          methodName: 'markCommentsRead',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SopLinkageEndpoint {
  _SopLinkageEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i78.CourseSopLink> linkSopToCourse(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseId,
    required int documentId,
    int? linkedById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sopLinkage',
            method: 'linkSopToCourse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sopLinkage',
          methodName: 'linkSopToCourse',
          parameters: _i1.testObjectToJson({
            'courseId': courseId,
            'documentId': documentId,
            'linkedById': linkedById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.CourseSopLink>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i78.CourseSopLink> unlinkSopFromCourse(
    _i1.TestSessionBuilder sessionBuilder, {
    required int linkId,
    int? unlinkedById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sopLinkage',
            method: 'unlinkSopFromCourse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sopLinkage',
          methodName: 'unlinkSopFromCourse',
          parameters: _i1.testObjectToJson({
            'linkId': linkId,
            'unlinkedById': unlinkedById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.CourseSopLink>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i78.CourseSopLink>> getLinkedSops(
    _i1.TestSessionBuilder sessionBuilder, {
    required int courseId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sopLinkage',
            method: 'getLinkedSops',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sopLinkage',
          methodName: 'getLinkedSops',
          parameters: _i1.testObjectToJson({'courseId': courseId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i78.CourseSopLink>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i78.CourseSopLink>> getCoursesForSop(
    _i1.TestSessionBuilder sessionBuilder, {
    required int documentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'sopLinkage',
            method: 'getCoursesForSop',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'sopLinkage',
          methodName: 'getCoursesForSop',
          parameters: _i1.testObjectToJson({'documentId': documentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i78.CourseSopLink>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StandaloneAssignmentEndpoint {
  _StandaloneAssignmentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i79.StandaloneAssignment?> createStandaloneAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
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
    String? assignedByType,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'createStandaloneAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'createStandaloneAssignment',
          parameters: _i1.testObjectToJson({
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
            'assignedByType': assignedByType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i79.StandaloneAssignment?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i79.StandaloneAssignment?> updateStandaloneAssignment(
    _i1.TestSessionBuilder sessionBuilder,
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'updateStandaloneAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'updateStandaloneAssignment',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i79.StandaloneAssignment?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i79.StandaloneAssignment?> publishStandaloneAssignment(
    _i1.TestSessionBuilder sessionBuilder,
    int assignmentId, {
    List<int>? individualUserIds,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'publishStandaloneAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'publishStandaloneAssignment',
          parameters: _i1.testObjectToJson({
            'assignmentId': assignmentId,
            'individualUserIds': individualUserIds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i79.StandaloneAssignment?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i79.StandaloneAssignment>>
  listStandaloneAssignmentsForOrganization(
    _i1.TestSessionBuilder sessionBuilder,
    int organizationId, {
    String? status,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'listStandaloneAssignmentsForOrganization',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'listStandaloneAssignmentsForOrganization',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'status': status,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i79.StandaloneAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i79.StandaloneAssignment?> getStandaloneAssignment(
    _i1.TestSessionBuilder sessionBuilder,
    int assignmentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'getStandaloneAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'getStandaloneAssignment',
          parameters: _i1.testObjectToJson({'assignmentId': assignmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i79.StandaloneAssignment?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i80.StandaloneAssignmentRecipient>>
  listMyStandaloneAssignmentRecipients(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'listMyStandaloneAssignmentRecipients',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'listMyStandaloneAssignmentRecipients',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i80.StandaloneAssignmentRecipient>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i80.StandaloneAssignmentRecipient?>
  getStandaloneAssignmentRecipient(
    _i1.TestSessionBuilder sessionBuilder,
    int recipientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'getStandaloneAssignmentRecipient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'getStandaloneAssignmentRecipient',
          parameters: _i1.testObjectToJson({'recipientId': recipientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i80.StandaloneAssignmentRecipient?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i80.StandaloneAssignmentRecipient?> submitStandaloneAssignment(
    _i1.TestSessionBuilder sessionBuilder,
    int recipientId, {
    required String responseJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'submitStandaloneAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'submitStandaloneAssignment',
          parameters: _i1.testObjectToJson({
            'recipientId': recipientId,
            'responseJson': responseJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i80.StandaloneAssignmentRecipient?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i80.StandaloneAssignmentRecipient?> gradeStandaloneSubmission(
    _i1.TestSessionBuilder sessionBuilder, {
    required int recipientId,
    required int grade,
    String? feedback,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'gradeStandaloneSubmission',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'gradeStandaloneSubmission',
          parameters: _i1.testObjectToJson({
            'recipientId': recipientId,
            'grade': grade,
            'feedback': feedback,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i80.StandaloneAssignmentRecipient?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i80.StandaloneAssignmentRecipient>> listSubmittedForGrading(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'standaloneAssignment',
            method: 'listSubmittedForGrading',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'standaloneAssignment',
          methodName: 'listSubmittedForGrading',
          parameters: _i1.testObjectToJson({'assignmentId': assignmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i80.StandaloneAssignmentRecipient>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TrainingBatchEndpoint {
  _TrainingBatchEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i81.TrainingBatch>> listBatches(
    _i1.TestSessionBuilder sessionBuilder, {
    required int organizationId,
    String? status,
    int? courseVersionId,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'listBatches',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'listBatches',
          parameters: _i1.testObjectToJson({
            'organizationId': organizationId,
            'status': status,
            'courseVersionId': courseVersionId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i81.TrainingBatch>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i81.TrainingBatch?> getBatch(
    _i1.TestSessionBuilder sessionBuilder,
    int batchId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'getBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'getBatch',
          parameters: _i1.testObjectToJson({'batchId': batchId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i81.TrainingBatch?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i81.TrainingBatch?> createBatch(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'createBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'createBatch',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i81.TrainingBatch?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i81.TrainingBatch?> updateBatch(
    _i1.TestSessionBuilder sessionBuilder,
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'updateBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'updateBatch',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i81.TrainingBatch?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteBatch(
    _i1.TestSessionBuilder sessionBuilder,
    int batchId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'deleteBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'deleteBatch',
          parameters: _i1.testObjectToJson({'batchId': batchId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, int>> getBatchStats(
    _i1.TestSessionBuilder sessionBuilder,
    int organizationId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'getBatchStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'getBatchStats',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i81.TrainingBatch>> listBatchesForCurrentUser(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'listBatchesForCurrentUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'listBatchesForCurrentUser',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i81.TrainingBatch>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i82.BatchParticipantInfo>> listBatchParticipantsForEmployee(
    _i1.TestSessionBuilder sessionBuilder,
    int batchId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'listBatchParticipantsForEmployee',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'listBatchParticipantsForEmployee',
          parameters: _i1.testObjectToJson({'batchId': batchId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i82.BatchParticipantInfo>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getBatchCohortProgress(
    _i1.TestSessionBuilder sessionBuilder,
    int batchId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'getBatchCohortProgress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'getBatchCohortProgress',
          parameters: _i1.testObjectToJson({'batchId': batchId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i83.TrainingBatchParticipant?> enrollUserInBatch(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    required int userId,
    String? role,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'enrollUserInBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'enrollUserInBatch',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'userId': userId,
            'role': role,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i83.TrainingBatchParticipant?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> removeUserFromBatch(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'removeUserFromBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'removeUserFromBatch',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'userId': userId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i84.BatchAttendanceRecord?> markAttendance(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    required int userId,
    int? liveClassId,
    required String status,
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'markAttendance',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'markAttendance',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'userId': userId,
            'liveClassId': liveClassId,
            'status': status,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i84.BatchAttendanceRecord?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i84.BatchAttendanceRecord>> bulkMarkAttendance(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    int? liveClassId,
    required List<Map<String, dynamic>> attendanceList,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'bulkMarkAttendance',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'bulkMarkAttendance',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'liveClassId': liveClassId,
            'attendanceList': attendanceList,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i84.BatchAttendanceRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i84.BatchAttendanceRecord>> listAttendance(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    int? liveClassId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'listAttendance',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'listAttendance',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'liveClassId': liveClassId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i84.BatchAttendanceRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<Map<String, String>>> getAttendanceSummary(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'getAttendanceSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'getAttendanceSummary',
          parameters: _i1.testObjectToJson({'batchId': batchId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<Map<String, String>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> closeBatch(
    _i1.TestSessionBuilder sessionBuilder, {
    required int batchId,
    required String signatureMeaning,
    String? passwordPlaintext,
    required double minAttendanceRate,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trainingBatch',
            method: 'closeBatch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trainingBatch',
          methodName: 'closeBatch',
          parameters: _i1.testObjectToJson({
            'batchId': batchId,
            'signatureMeaning': signatureMeaning,
            'passwordPlaintext': passwordPlaintext,
            'minAttendanceRate': minAttendanceRate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TrainingEndpoint {
  _TrainingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i9.SignatureMeaning>> listSignatureMeanings(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'listSignatureMeanings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'listSignatureMeanings',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.SignatureMeaning>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.TrainingAssignment>> getAssignmentsForUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getAssignmentsForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getAssignmentsForUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.TrainingAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.TrainingAssignment> assignTraining(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    required String priority,
    String? reason,
    required String source,
    required bool forceReassign,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'assignTraining',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'assignTraining',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'courseVersionId': courseVersionId,
            'assignedById': assignedById,
            'dueDate': dueDate,
            'priority': priority,
            'reason': reason,
            'source': source,
            'forceReassign': forceReassign,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.TrainingAssignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.TrainingAssignment> updateAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
    DateTime? dueDate,
    String? priority,
    required int updatedById,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'updateAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'updateAssignment',
          parameters: _i1.testObjectToJson({
            'assignmentId': assignmentId,
            'dueDate': dueDate,
            'priority': priority,
            'updatedById': updatedById,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.TrainingAssignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.TrainingAssignment> cancelAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
    required int cancelledById,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'cancelAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'cancelAssignment',
          parameters: _i1.testObjectToJson({
            'assignmentId': assignmentId,
            'cancelledById': cancelledById,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.TrainingAssignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i85.Enrollment>> getEnrollmentsForUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getEnrollmentsForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getEnrollmentsForUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i85.Enrollment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String?> getEnrollmentResumePosition(
    _i1.TestSessionBuilder sessionBuilder,
    int enrollmentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getEnrollmentResumePosition',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getEnrollmentResumePosition',
          parameters: _i1.testObjectToJson({'enrollmentId': enrollmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i85.Enrollment?> getEnrollmentById(
    _i1.TestSessionBuilder sessionBuilder,
    int enrollmentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getEnrollmentById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getEnrollmentById',
          parameters: _i1.testObjectToJson({'enrollmentId': enrollmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i85.Enrollment?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i85.Enrollment> acknowledgeRetraining(
    _i1.TestSessionBuilder sessionBuilder, {
    required int enrollmentId,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'acknowledgeRetraining',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'acknowledgeRetraining',
          parameters: _i1.testObjectToJson({
            'enrollmentId': enrollmentId,
            'userId': userId,
            'signatureMeaning': signatureMeaning,
            'passwordPlaintext': passwordPlaintext,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i85.Enrollment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i21.Certificate>> getCertificatesForUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getCertificatesForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getCertificatesForUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.Certificate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i86.TrainingRecord>> getTrainingRecordsForUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getTrainingRecordsForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getTrainingRecordsForUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i86.TrainingRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i21.Certificate?> getCertificateById(
    _i1.TestSessionBuilder sessionBuilder,
    int certificateId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getCertificateById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getCertificateById',
          parameters: _i1.testObjectToJson({'certificateId': certificateId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i21.Certificate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.TrainingWaiver?> getWaiverById(
    _i1.TestSessionBuilder sessionBuilder,
    int waiverId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getWaiverById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getWaiverById',
          parameters: _i1.testObjectToJson({'waiverId': waiverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i14.TrainingWaiver?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i87.SignatureVerificationResult> getSignatureWithIntegrityCheck(
    _i1.TestSessionBuilder sessionBuilder,
    int signatureId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getSignatureWithIntegrityCheck',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getSignatureWithIntegrityCheck',
          parameters: _i1.testObjectToJson({'signatureId': signatureId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i87.SignatureVerificationResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i88.ElectronicSignature>> listElectronicSignatures(
    _i1.TestSessionBuilder sessionBuilder, {
    DateTime? from,
    DateTime? to,
    String? entityType,
    int? userId,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'listElectronicSignatures',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'listElectronicSignatures',
          parameters: _i1.testObjectToJson({
            'from': from,
            'to': to,
            'entityType': entityType,
            'userId': userId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i88.ElectronicSignature>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> issueBiometricToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required String passwordPlaintext,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'issueBiometricToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'issueBiometricToken',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'passwordPlaintext': passwordPlaintext,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> createTrainingSignature(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordPlaintext,
    String? biometricToken,
    String? ipAddress,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'createTrainingSignature',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'createTrainingSignature',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'signatureMeaning': signatureMeaning,
            'entityType': entityType,
            'entityId': entityId,
            'passwordPlaintext': passwordPlaintext,
            'biometricToken': biometricToken,
            'ipAddress': ipAddress,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i21.Certificate> completeTraining(
    _i1.TestSessionBuilder sessionBuilder, {
    required int enrollmentId,
    required int userId,
    required int courseVersionId,
    required int esignatureId,
    int? score,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'completeTraining',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'completeTraining',
          parameters: _i1.testObjectToJson({
            'enrollmentId': enrollmentId,
            'userId': userId,
            'courseVersionId': courseVersionId,
            'esignatureId': esignatureId,
            'score': score,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i21.Certificate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i89.TrainingRecordAnnotation>> listAnnotations(
    _i1.TestSessionBuilder sessionBuilder,
    int trainingRecordId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'listAnnotations',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'listAnnotations',
          parameters: _i1.testObjectToJson({
            'trainingRecordId': trainingRecordId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i89.TrainingRecordAnnotation>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i89.TrainingRecordAnnotation> addAnnotation(
    _i1.TestSessionBuilder sessionBuilder, {
    required int trainingRecordId,
    required int authorId,
    required String note,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'addAnnotation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'addAnnotation',
          parameters: _i1.testObjectToJson({
            'trainingRecordId': trainingRecordId,
            'authorId': authorId,
            'note': note,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i89.TrainingRecordAnnotation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> revokeSignature(
    _i1.TestSessionBuilder sessionBuilder, {
    required int signatureId,
    required String reason,
    required String passwordPlaintext,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'revokeSignature',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'revokeSignature',
          parameters: _i1.testObjectToJson({
            'signatureId': signatureId,
            'reason': reason,
            'passwordPlaintext': passwordPlaintext,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.TrainingAssignment> qaApproveAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? comments,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'qaApproveAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'qaApproveAssignment',
          parameters: _i1.testObjectToJson({
            'assignmentId': assignmentId,
            'signatureMeaning': signatureMeaning,
            'passwordPlaintext': passwordPlaintext,
            'comments': comments,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.TrainingAssignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.TrainingAssignment> qaRejectAssignment(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
    required String reason,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'qaRejectAssignment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'qaRejectAssignment',
          parameters: _i1.testObjectToJson({
            'assignmentId': assignmentId,
            'reason': reason,
            'signatureMeaning': signatureMeaning,
            'passwordPlaintext': passwordPlaintext,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.TrainingAssignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.TrainingAssignment> submitForQaApproval(
    _i1.TestSessionBuilder sessionBuilder, {
    required int assignmentId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'submitForQaApproval',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'submitForQaApproval',
          parameters: _i1.testObjectToJson({'assignmentId': assignmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.TrainingAssignment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i85.Enrollment> selfEnroll(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int courseVersionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'selfEnroll',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'selfEnroll',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i85.Enrollment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i7.PharmaUser>>
  listLearnersEnrolledInTrainerPublishedCourses(
    _i1.TestSessionBuilder sessionBuilder, {
    String? search,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'listLearnersEnrolledInTrainerPublishedCourses',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'listLearnersEnrolledInTrainerPublishedCourses',
          parameters: _i1.testObjectToJson({
            'search': search,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i7.PharmaUser>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i85.Enrollment>> getEnrollmentsForCourseVersion(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getEnrollmentsForCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getEnrollmentsForCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i85.Enrollment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.TrainingAssignment>> getAssignmentsForCourseVersion(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getAssignmentsForCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getAssignmentsForCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.TrainingAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.TrainingAssignment>> getAllAssignments(
    _i1.TestSessionBuilder sessionBuilder, {
    int? organizationId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getAllAssignments',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getAllAssignments',
          parameters: _i1.testObjectToJson({'organizationId': organizationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.TrainingAssignment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i86.TrainingRecord>> getTrainingRecordsForCourseVersion(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getTrainingRecordsForCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getTrainingRecordsForCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i86.TrainingRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getEnrollmentProgress(
    _i1.TestSessionBuilder sessionBuilder,
    int enrollmentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getEnrollmentProgress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getEnrollmentProgress',
          parameters: _i1.testObjectToJson({'enrollmentId': enrollmentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isCourseContentComplete(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int courseVersionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'isCourseContentComplete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'isCourseContentComplete',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i21.Certificate>> getCertificatesForCourseVersion(
    _i1.TestSessionBuilder sessionBuilder,
    int courseVersionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'training',
            method: 'getCertificatesForCourseVersion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'training',
          methodName: 'getCertificatesForCourseVersion',
          parameters: _i1.testObjectToJson({
            'courseVersionId': courseVersionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.Certificate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _UserEndpoint {
  _UserEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i7.PharmaUser?> getUser(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'getUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getUser',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.PharmaUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.PharmaUser?> getUserByEmail(
    _i1.TestSessionBuilder sessionBuilder,
    String email,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'getUserByEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getUserByEmail',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.PharmaUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String?> getUserRoleByEmail(
    _i1.TestSessionBuilder sessionBuilder,
    String email,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'getUserRoleByEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getUserRoleByEmail',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i90.UserPreference>> getUserPreferences(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'getUserPreferences',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getUserPreferences',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i90.UserPreference>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i90.UserPreference> setUserPreference(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required String key,
    required String value,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'setUserPreference',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'setUserPreference',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'key': key,
            'value': value,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i90.UserPreference>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ValidationEndpoint {
  _ValidationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String> generateUrs(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'validation',
            method: 'generateUrs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'validation',
          methodName: 'generateUrs',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> generateFs(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'validation',
            method: 'generateFs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'validation',
          methodName: 'generateFs',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> generateDs(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'validation',
            method: 'generateDs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'validation',
          methodName: 'generateDs',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> generateIq(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'validation',
            method: 'generateIq',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'validation',
          methodName: 'generateIq',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> generateOq(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'validation',
            method: 'generateOq',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'validation',
          methodName: 'generateOq',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> generatePq(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'validation',
            method: 'generatePq',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'validation',
          methodName: 'generatePq',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> generateTraceabilityMatrix(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'validation',
            method: 'generateTraceabilityMatrix',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'validation',
          methodName: 'generateTraceabilityMatrix',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _GreetingEndpoint {
  _GreetingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i91.Greeting> hello(
    _i1.TestSessionBuilder sessionBuilder,
    String name,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'greeting',
            method: 'hello',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'greeting',
          methodName: 'hello',
          parameters: _i1.testObjectToJson({'name': name}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i91.Greeting>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CapaEffectivenessWorkerFutureCall {
  Future<void> run(_i1.TestSessionBuilder sessionBuilder) async {
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.CapaEffectivenessWorkerRunFutureCall().invoke(
        _localUniqueSession,
        null,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }
}

class _CertificationExpiryWorkerFutureCall {
  Future<void> run(_i1.TestSessionBuilder sessionBuilder) async {
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.CertificationExpiryWorkerRunFutureCall().invoke(
        _localUniqueSession,
        null,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }
}

class _ComplianceMonitorWorkerFutureCall {
  Future<void> run(_i1.TestSessionBuilder sessionBuilder) async {
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.ComplianceMonitorWorkerRunFutureCall().invoke(
        _localUniqueSession,
        null,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }
}

class _FailedLoginLockoutWorkerFutureCall {
  Future<void> run(_i1.TestSessionBuilder sessionBuilder) async {
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.FailedLoginLockoutWorkerRunFutureCall().invoke(
        _localUniqueSession,
        null,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }
}

class _KafkaEventProcessorFutureCall {
  Future<void> processSopUpdated(
    _i1.TestSessionBuilder sessionBuilder, {
    required String documentId,
    required String courseVersionId,
    required String reason,
  }) async {
    var object = _i93.KafkaEventProcessorProcessSopUpdatedModel(
      documentId: documentId,
      courseVersionId: courseVersionId,
      reason: reason,
    );
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.KafkaEventProcessorProcessSopUpdatedFutureCall().invoke(
        _localUniqueSession,
        object,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }

  Future<void> processEmployeeCreated(
    _i1.TestSessionBuilder sessionBuilder, {
    required String userId,
    required String departmentId,
    required String roleId,
  }) async {
    var object = _i94.KafkaEventProcessorProcessEmployeeCreatedModel(
      userId: userId,
      departmentId: departmentId,
      roleId: roleId,
    );
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.KafkaEventProcessorProcessEmployeeCreatedFutureCall().invoke(
        _localUniqueSession,
        object,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }

  Future<void> processEmployeeTransferred(
    _i1.TestSessionBuilder sessionBuilder, {
    required String userId,
    required String oldDepartmentId,
    required String newDepartmentId,
    required String oldRoleId,
    required String newRoleId,
  }) async {
    var object = _i95.KafkaEventProcessorProcessEmployeeTransferredModel(
      userId: userId,
      oldDepartmentId: oldDepartmentId,
      newDepartmentId: newDepartmentId,
      oldRoleId: oldRoleId,
      newRoleId: newRoleId,
    );
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.KafkaEventProcessorProcessEmployeeTransferredFutureCall()
          .invoke(
            _localUniqueSession,
            object,
          );
    } finally {
      await _localUniqueSession.close();
    }
  }

  Future<void> processOutbox(_i1.TestSessionBuilder sessionBuilder) async {
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.KafkaEventProcessorProcessOutboxFutureCall().invoke(
        _localUniqueSession,
        null,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }
}

class _RetentionArchivalWorkerFutureCall {
  Future<void> run(_i1.TestSessionBuilder sessionBuilder) async {
    var _localUniqueSession = (sessionBuilder as _i1.InternalTestSessionBuilder)
        .internalBuild();
    try {
      await _i92.RetentionArchivalWorkerRunFutureCall().invoke(
        _localUniqueSession,
        null,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }
}
