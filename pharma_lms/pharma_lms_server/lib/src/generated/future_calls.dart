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
import 'future_calls_generated_models/kafka_event_processor_process_sop_updated_model.dart'
    as _i2;
import 'future_calls_generated_models/kafka_event_processor_process_employee_created_model.dart'
    as _i3;
import 'dart:async' as _i4;
import '../workers/certification_expiry_worker.dart' as _i5;
import '../workers/compliance_monitor_worker.dart' as _i6;
import '../workers/kafka_event_processor.dart' as _i7;

/// Invokes a future call.
typedef _InvokeFutureCall =
    Future<void> Function(String name, _i1.SerializableModel? object);

extension ServerpodFutureCallsGetter on _i1.Serverpod {
  /// Generated future calls.
  FutureCalls get futureCalls => FutureCalls();
}

class FutureCalls extends _i1.FutureCallDispatch<_FutureCallRef> {
  FutureCalls._();

  factory FutureCalls() {
    return _instance;
  }

  static final FutureCalls _instance = FutureCalls._();

  _i1.FutureCallManager? _futureCallManager;

  String? _serverId;

  String get _effectiveServerId {
    if (_serverId == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _serverId!;
  }

  _i1.FutureCallManager get _effectiveFutureCallManager {
    if (_futureCallManager == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _futureCallManager!;
  }

  @override
  void initialize(
    _i1.FutureCallManager futureCallManager,
    String serverId,
  ) {
    var registeredFutureCalls = <String, _i1.FutureCall>{
      'CertificationExpiryWorkerRunFutureCall':
          CertificationExpiryWorkerRunFutureCall(),
      'ComplianceMonitorWorkerRunFutureCall':
          ComplianceMonitorWorkerRunFutureCall(),
      'KafkaEventProcessorProcessSopUpdatedFutureCall':
          KafkaEventProcessorProcessSopUpdatedFutureCall(),
      'KafkaEventProcessorProcessEmployeeCreatedFutureCall':
          KafkaEventProcessorProcessEmployeeCreatedFutureCall(),
      'KafkaEventProcessorProcessOutboxFutureCall':
          KafkaEventProcessorProcessOutboxFutureCall(),
    };
    _futureCallManager = futureCallManager;
    _serverId = serverId;
    for (final entry in registeredFutureCalls.entries) {
      _futureCallManager?.registerFutureCall(entry.value, entry.key);
    }
  }

  @override
  _FutureCallRef callAtTime(
    DateTime time, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          time,
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _FutureCallRef callWithDelay(
    Duration delay, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          DateTime.now().toUtc().add(delay),
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  Future<void> cancel(String identifier) async {
    await _effectiveFutureCallManager.cancelFutureCall(identifier);
  }
}

class _FutureCallRef {
  _FutureCallRef(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  late final certificationExpiryWorker =
      _CertificationExpiryWorkerFutureCallDispatcher(_invokeFutureCall);

  late final complianceMonitorWorker =
      _ComplianceMonitorWorkerFutureCallDispatcher(_invokeFutureCall);

  late final kafkaEventProcessor = _KafkaEventProcessorFutureCallDispatcher(
    _invokeFutureCall,
  );
}

class _CertificationExpiryWorkerFutureCallDispatcher {
  _CertificationExpiryWorkerFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> run() {
    return _invokeFutureCall(
      'CertificationExpiryWorkerRunFutureCall',
      null,
    );
  }
}

class _ComplianceMonitorWorkerFutureCallDispatcher {
  _ComplianceMonitorWorkerFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> run() {
    return _invokeFutureCall(
      'ComplianceMonitorWorkerRunFutureCall',
      null,
    );
  }
}

class _KafkaEventProcessorFutureCallDispatcher {
  _KafkaEventProcessorFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> processSopUpdated({
    required String documentId,
    required String courseVersionId,
    required String reason,
  }) {
    var object = _i2.KafkaEventProcessorProcessSopUpdatedModel(
      documentId: documentId,
      courseVersionId: courseVersionId,
      reason: reason,
    );
    return _invokeFutureCall(
      'KafkaEventProcessorProcessSopUpdatedFutureCall',
      object,
    );
  }

  Future<void> processEmployeeCreated({
    required String userId,
    required String departmentId,
    required String roleId,
  }) {
    var object = _i3.KafkaEventProcessorProcessEmployeeCreatedModel(
      userId: userId,
      departmentId: departmentId,
      roleId: roleId,
    );
    return _invokeFutureCall(
      'KafkaEventProcessorProcessEmployeeCreatedFutureCall',
      object,
    );
  }

  Future<void> processOutbox() {
    return _invokeFutureCall(
      'KafkaEventProcessorProcessOutboxFutureCall',
      null,
    );
  }
}

class CertificationExpiryWorkerRunFutureCall extends _i1.FutureCall {
  @override
  _i4.Future<void> invoke(
    _i1.Session session,
    _i1.SerializableModel? object,
  ) async {
    await _i5.CertificationExpiryWorker().run(session);
  }
}

class ComplianceMonitorWorkerRunFutureCall extends _i1.FutureCall {
  @override
  _i4.Future<void> invoke(
    _i1.Session session,
    _i1.SerializableModel? object,
  ) async {
    await _i6.ComplianceMonitorWorker().run(session);
  }
}

/// Process SOP updated event - assign retraining to affected employees.
class KafkaEventProcessorProcessSopUpdatedFutureCall
    extends _i1.FutureCall<_i2.KafkaEventProcessorProcessSopUpdatedModel> {
  @override
  _i4.Future<void> invoke(
    _i1.Session session,
    _i2.KafkaEventProcessorProcessSopUpdatedModel? object,
  ) async {
    if (object != null) {
      await _i7.KafkaEventProcessor().processSopUpdated(
        session,
        documentId: object.documentId,
        courseVersionId: object.courseVersionId,
        reason: object.reason,
      );
    }
  }
}

/// Process employee created event - assign role-based training.
class KafkaEventProcessorProcessEmployeeCreatedFutureCall
    extends _i1.FutureCall<_i3.KafkaEventProcessorProcessEmployeeCreatedModel> {
  @override
  _i4.Future<void> invoke(
    _i1.Session session,
    _i3.KafkaEventProcessorProcessEmployeeCreatedModel? object,
  ) async {
    if (object != null) {
      await _i7.KafkaEventProcessor().processEmployeeCreated(
        session,
        userId: object.userId,
        departmentId: object.departmentId,
        roleId: object.roleId,
      );
    }
  }
}

/// Process outbox messages - publish to Kafka.
class KafkaEventProcessorProcessOutboxFutureCall extends _i1.FutureCall {
  @override
  _i4.Future<void> invoke(
    _i1.Session session,
    _i1.SerializableModel? object,
  ) async {
    await _i7.KafkaEventProcessor().processOutbox(session);
  }
}
