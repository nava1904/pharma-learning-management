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
import 'future_calls_generated_models/kafka_event_processor_process_employee_transferred_model.dart'
    as _i4;
import 'dart:async' as _i5;
import '../workers/capa_effectiveness_worker.dart' as _i6;
import '../workers/certification_expiry_worker.dart' as _i7;
import '../workers/compliance_monitor_worker.dart' as _i8;
import '../workers/kafka_event_processor.dart' as _i9;

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
      'CapaEffectivenessWorkerRunFutureCall':
          CapaEffectivenessWorkerRunFutureCall(),
      'CertificationExpiryWorkerRunFutureCall':
          CertificationExpiryWorkerRunFutureCall(),
      'ComplianceMonitorWorkerRunFutureCall':
          ComplianceMonitorWorkerRunFutureCall(),
      'KafkaEventProcessorProcessSopUpdatedFutureCall':
          KafkaEventProcessorProcessSopUpdatedFutureCall(),
      'KafkaEventProcessorProcessEmployeeCreatedFutureCall':
          KafkaEventProcessorProcessEmployeeCreatedFutureCall(),
      'KafkaEventProcessorProcessEmployeeTransferredFutureCall':
          KafkaEventProcessorProcessEmployeeTransferredFutureCall(),
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

  late final capaEffectivenessWorker =
      _CapaEffectivenessWorkerFutureCallDispatcher(_invokeFutureCall);

  late final certificationExpiryWorker =
      _CertificationExpiryWorkerFutureCallDispatcher(_invokeFutureCall);

  late final complianceMonitorWorker =
      _ComplianceMonitorWorkerFutureCallDispatcher(_invokeFutureCall);

  late final kafkaEventProcessor = _KafkaEventProcessorFutureCallDispatcher(
    _invokeFutureCall,
  );
}

class _CapaEffectivenessWorkerFutureCallDispatcher {
  _CapaEffectivenessWorkerFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> run() {
    return _invokeFutureCall(
      'CapaEffectivenessWorkerRunFutureCall',
      null,
    );
  }
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

  Future<void> processEmployeeTransferred({
    required String userId,
    required String oldDepartmentId,
    required String newDepartmentId,
    required String oldRoleId,
    required String newRoleId,
  }) {
    var object = _i4.KafkaEventProcessorProcessEmployeeTransferredModel(
      userId: userId,
      oldDepartmentId: oldDepartmentId,
      newDepartmentId: newDepartmentId,
      oldRoleId: oldRoleId,
      newRoleId: newRoleId,
    );
    return _invokeFutureCall(
      'KafkaEventProcessorProcessEmployeeTransferredFutureCall',
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

class CapaEffectivenessWorkerRunFutureCall extends _i1.FutureCall {
  @override
  _i5.Future<void> invoke(
    _i1.Session session,
    _i1.SerializableModel? object,
  ) async {
    await _i6.CapaEffectivenessWorker().run(session);
  }
}

class CertificationExpiryWorkerRunFutureCall extends _i1.FutureCall {
  @override
  _i5.Future<void> invoke(
    _i1.Session session,
    _i1.SerializableModel? object,
  ) async {
    await _i7.CertificationExpiryWorker().run(session);
  }
}

class ComplianceMonitorWorkerRunFutureCall extends _i1.FutureCall {
  @override
  _i5.Future<void> invoke(
    _i1.Session session,
    _i1.SerializableModel? object,
  ) async {
    await _i8.ComplianceMonitorWorker().run(session);
  }
}

/// Process SOP updated event - assign retraining to affected employees.
/// QA gate: only assigns when document.trainingRequiredByQa == 'training_required'.
/// Scoping: uses affectedDepartmentIdsJson and affectedRoleIdsJson when set.
class KafkaEventProcessorProcessSopUpdatedFutureCall
    extends _i1.FutureCall<_i2.KafkaEventProcessorProcessSopUpdatedModel> {
  @override
  _i5.Future<void> invoke(
    _i1.Session session,
    _i2.KafkaEventProcessorProcessSopUpdatedModel? object,
  ) async {
    if (object != null) {
      await _i9.KafkaEventProcessor().processSopUpdated(
        session,
        documentId: object.documentId,
        courseVersionId: object.courseVersionId,
        reason: object.reason,
      );
    }
  }
}

/// Process employee created event - assign role-based training.
/// Uses TrainingMatrix when available, else all effective course versions.
class KafkaEventProcessorProcessEmployeeCreatedFutureCall
    extends _i1.FutureCall<_i3.KafkaEventProcessorProcessEmployeeCreatedModel> {
  @override
  _i5.Future<void> invoke(
    _i1.Session session,
    _i3.KafkaEventProcessorProcessEmployeeCreatedModel? object,
  ) async {
    if (object != null) {
      await _i9.KafkaEventProcessor().processEmployeeCreated(
        session,
        userId: object.userId,
        departmentId: object.departmentId,
        roleId: object.roleId,
      );
    }
  }
}

/// Process employee transferred - archive old assignments, assign delta for new role/dept.
class KafkaEventProcessorProcessEmployeeTransferredFutureCall
    extends
        _i1.FutureCall<_i4.KafkaEventProcessorProcessEmployeeTransferredModel> {
  @override
  _i5.Future<void> invoke(
    _i1.Session session,
    _i4.KafkaEventProcessorProcessEmployeeTransferredModel? object,
  ) async {
    if (object != null) {
      await _i9.KafkaEventProcessor().processEmployeeTransferred(
        session,
        userId: object.userId,
        oldDepartmentId: object.oldDepartmentId,
        newDepartmentId: object.newDepartmentId,
        oldRoleId: object.oldRoleId,
        newRoleId: object.newRoleId,
      );
    }
  }
}

/// Process outbox messages - publish to Kafka. Moves to DLQ after 3 retries.
class KafkaEventProcessorProcessOutboxFutureCall extends _i1.FutureCall {
  @override
  _i5.Future<void> invoke(
    _i1.Session session,
    _i1.SerializableModel? object,
  ) async {
    await _i9.KafkaEventProcessor().processOutbox(session);
  }
}
