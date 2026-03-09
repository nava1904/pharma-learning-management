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

/// Import log for bulk operations. FDA 21 CFR Part 11.
abstract class ImportLog implements _i1.SerializableModel {
  ImportLog._({
    this.id,
    required this.importedById,
    this.importedBy,
    required this.importType,
    this.filename,
    this.recordCount,
    this.successCount,
    this.failureCount,
    this.failureDetailsJson,
    DateTime? importedAt,
  }) : importedAt = importedAt ?? DateTime.now();

  factory ImportLog({
    int? id,
    required int importedById,
    _i2.PharmaUser? importedBy,
    required String importType,
    String? filename,
    int? recordCount,
    int? successCount,
    int? failureCount,
    String? failureDetailsJson,
    DateTime? importedAt,
  }) = _ImportLogImpl;

  factory ImportLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ImportLog(
      id: jsonSerialization['id'] as int?,
      importedById: jsonSerialization['importedById'] as int,
      importedBy: jsonSerialization['importedBy'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['importedBy'],
            ),
      importType: jsonSerialization['importType'] as String,
      filename: jsonSerialization['filename'] as String?,
      recordCount: jsonSerialization['recordCount'] as int?,
      successCount: jsonSerialization['successCount'] as int?,
      failureCount: jsonSerialization['failureCount'] as int?,
      failureDetailsJson: jsonSerialization['failureDetailsJson'] as String?,
      importedAt: jsonSerialization['importedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['importedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int importedById;

  /// Who performed the import.
  _i2.PharmaUser? importedBy;

  /// Import type: employee, course, assignment.
  String importType;

  /// Original filename.
  String? filename;

  /// Total records in file.
  int? recordCount;

  /// Successfully imported count.
  int? successCount;

  /// Failed count.
  int? failureCount;

  /// Failure details as JSON.
  String? failureDetailsJson;

  /// When imported.
  DateTime importedAt;

  /// Returns a shallow copy of this [ImportLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ImportLog copyWith({
    int? id,
    int? importedById,
    _i2.PharmaUser? importedBy,
    String? importType,
    String? filename,
    int? recordCount,
    int? successCount,
    int? failureCount,
    String? failureDetailsJson,
    DateTime? importedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ImportLog',
      if (id != null) 'id': id,
      'importedById': importedById,
      if (importedBy != null) 'importedBy': importedBy?.toJson(),
      'importType': importType,
      if (filename != null) 'filename': filename,
      if (recordCount != null) 'recordCount': recordCount,
      if (successCount != null) 'successCount': successCount,
      if (failureCount != null) 'failureCount': failureCount,
      if (failureDetailsJson != null) 'failureDetailsJson': failureDetailsJson,
      'importedAt': importedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ImportLogImpl extends ImportLog {
  _ImportLogImpl({
    int? id,
    required int importedById,
    _i2.PharmaUser? importedBy,
    required String importType,
    String? filename,
    int? recordCount,
    int? successCount,
    int? failureCount,
    String? failureDetailsJson,
    DateTime? importedAt,
  }) : super._(
         id: id,
         importedById: importedById,
         importedBy: importedBy,
         importType: importType,
         filename: filename,
         recordCount: recordCount,
         successCount: successCount,
         failureCount: failureCount,
         failureDetailsJson: failureDetailsJson,
         importedAt: importedAt,
       );

  /// Returns a shallow copy of this [ImportLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ImportLog copyWith({
    Object? id = _Undefined,
    int? importedById,
    Object? importedBy = _Undefined,
    String? importType,
    Object? filename = _Undefined,
    Object? recordCount = _Undefined,
    Object? successCount = _Undefined,
    Object? failureCount = _Undefined,
    Object? failureDetailsJson = _Undefined,
    DateTime? importedAt,
  }) {
    return ImportLog(
      id: id is int? ? id : this.id,
      importedById: importedById ?? this.importedById,
      importedBy: importedBy is _i2.PharmaUser?
          ? importedBy
          : this.importedBy?.copyWith(),
      importType: importType ?? this.importType,
      filename: filename is String? ? filename : this.filename,
      recordCount: recordCount is int? ? recordCount : this.recordCount,
      successCount: successCount is int? ? successCount : this.successCount,
      failureCount: failureCount is int? ? failureCount : this.failureCount,
      failureDetailsJson: failureDetailsJson is String?
          ? failureDetailsJson
          : this.failureDetailsJson,
      importedAt: importedAt ?? this.importedAt,
    );
  }
}
