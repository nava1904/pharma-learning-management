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
import '../organization/user.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Per-user key/value preferences (email notifications, auto-save, dark mode).
abstract class UserPreference implements _i1.SerializableModel {
  UserPreference._({
    this.id,
    required this.userId,
    this.user,
    required this.preferenceKey,
    required this.preferenceValue,
  });

  factory UserPreference({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String preferenceKey,
    required String preferenceValue,
  }) = _UserPreferenceImpl;

  factory UserPreference.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPreference(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      preferenceKey: jsonSerialization['preferenceKey'] as String,
      preferenceValue: jsonSerialization['preferenceValue'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user this preference belongs to.
  _i2.PharmaUser? user;

  /// Preference key: email_notifications, auto_save_drafts, dark_mode, etc.
  String preferenceKey;

  /// Preference value as string.
  String preferenceValue;

  /// Returns a shallow copy of this [UserPreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPreference copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    String? preferenceKey,
    String? preferenceValue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserPreference',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'preferenceKey': preferenceKey,
      'preferenceValue': preferenceValue,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPreferenceImpl extends UserPreference {
  _UserPreferenceImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String preferenceKey,
    required String preferenceValue,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         preferenceKey: preferenceKey,
         preferenceValue: preferenceValue,
       );

  /// Returns a shallow copy of this [UserPreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPreference copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? preferenceKey,
    String? preferenceValue,
  }) {
    return UserPreference(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      preferenceKey: preferenceKey ?? this.preferenceKey,
      preferenceValue: preferenceValue ?? this.preferenceValue,
    );
  }
}
