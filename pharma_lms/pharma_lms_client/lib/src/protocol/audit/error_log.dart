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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// Error log for system failures and exceptions.
abstract class ErrorLog implements _i1.SerializableModel {
  ErrorLog._({
    this.id,
    required this.message,
    this.stackTrace,
    this.contextJson,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ErrorLog({
    int? id,
    required String message,
    String? stackTrace,
    String? contextJson,
    DateTime? timestamp,
  }) = _ErrorLogImpl;

  factory ErrorLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ErrorLog(
      id: jsonSerialization['id'] as int?,
      message: jsonSerialization['message'] as String,
      stackTrace: jsonSerialization['stackTrace'] as String?,
      contextJson: jsonSerialization['contextJson'] as String?,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Error message.
  String message;

  /// Stack trace.
  String? stackTrace;

  /// Additional context as JSON.
  String? contextJson;

  /// Timestamp.
  DateTime timestamp;

  /// Returns a shallow copy of this [ErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ErrorLog copyWith({
    int? id,
    String? message,
    String? stackTrace,
    String? contextJson,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ErrorLog',
      if (id != null) 'id': id,
      'message': message,
      if (stackTrace != null) 'stackTrace': stackTrace,
      if (contextJson != null) 'contextJson': contextJson,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ErrorLogImpl extends ErrorLog {
  _ErrorLogImpl({
    int? id,
    required String message,
    String? stackTrace,
    String? contextJson,
    DateTime? timestamp,
  }) : super._(
         id: id,
         message: message,
         stackTrace: stackTrace,
         contextJson: contextJson,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [ErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ErrorLog copyWith({
    Object? id = _Undefined,
    String? message,
    Object? stackTrace = _Undefined,
    Object? contextJson = _Undefined,
    DateTime? timestamp,
  }) {
    return ErrorLog(
      id: id is int? ? id : this.id,
      message: message ?? this.message,
      stackTrace: stackTrace is String? ? stackTrace : this.stackTrace,
      contextJson: contextJson is String? ? contextJson : this.contextJson,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
