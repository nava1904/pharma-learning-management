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

/// Safe roster row for employee batch UI (no sensitive fields).
abstract class BatchParticipantInfo implements _i1.SerializableModel {
  BatchParticipantInfo._({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.role,
  });

  factory BatchParticipantInfo({
    required int userId,
    required String firstName,
    required String lastName,
    required String email,
    String? role,
  }) = _BatchParticipantInfoImpl;

  factory BatchParticipantInfo.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BatchParticipantInfo(
      userId: jsonSerialization['userId'] as int,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      email: jsonSerialization['email'] as String,
      role: jsonSerialization['role'] as String?,
    );
  }

  int userId;

  String firstName;

  String lastName;

  String email;

  String? role;

  /// Returns a shallow copy of this [BatchParticipantInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchParticipantInfo copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BatchParticipantInfo',
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      if (role != null) 'role': role,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BatchParticipantInfoImpl extends BatchParticipantInfo {
  _BatchParticipantInfoImpl({
    required int userId,
    required String firstName,
    required String lastName,
    required String email,
    String? role,
  }) : super._(
         userId: userId,
         firstName: firstName,
         lastName: lastName,
         email: email,
         role: role,
       );

  /// Returns a shallow copy of this [BatchParticipantInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchParticipantInfo copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    Object? role = _Undefined,
  }) {
    return BatchParticipantInfo(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role is String? ? role : this.role,
    );
  }
}
