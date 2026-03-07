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
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i2;

/// Result of bulk user import.
abstract class BulkImportResult implements _i1.SerializableModel {
  BulkImportResult._({
    required this.imported,
    required this.errors,
  });

  factory BulkImportResult({
    required int imported,
    required List<String> errors,
  }) = _BulkImportResultImpl;

  factory BulkImportResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return BulkImportResult(
      imported: jsonSerialization['imported'] as int,
      errors: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['errors'],
      ),
    );
  }

  int imported;

  List<String> errors;

  /// Returns a shallow copy of this [BulkImportResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BulkImportResult copyWith({
    int? imported,
    List<String>? errors,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BulkImportResult',
      'imported': imported,
      'errors': errors.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BulkImportResultImpl extends BulkImportResult {
  _BulkImportResultImpl({
    required int imported,
    required List<String> errors,
  }) : super._(
         imported: imported,
         errors: errors,
       );

  /// Returns a shallow copy of this [BulkImportResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BulkImportResult copyWith({
    int? imported,
    List<String>? errors,
  }) {
    return BulkImportResult(
      imported: imported ?? this.imported,
      errors: errors ?? this.errors.map((e0) => e0).toList(),
    );
  }
}
