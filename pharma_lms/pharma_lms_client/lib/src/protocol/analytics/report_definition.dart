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

/// Report definition for analytics.
abstract class ReportDefinition implements _i1.SerializableModel {
  ReportDefinition._({
    this.id,
    required this.name,
    required this.reportType,
    this.querySql,
    this.paramsJson,
  });

  factory ReportDefinition({
    int? id,
    required String name,
    required String reportType,
    String? querySql,
    String? paramsJson,
  }) = _ReportDefinitionImpl;

  factory ReportDefinition.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportDefinition(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      reportType: jsonSerialization['reportType'] as String,
      querySql: jsonSerialization['querySql'] as String?,
      paramsJson: jsonSerialization['paramsJson'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Report name.
  String name;

  /// Report type.
  String reportType;

  /// Query SQL or template.
  String? querySql;

  /// Parameters as JSON.
  String? paramsJson;

  /// Returns a shallow copy of this [ReportDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportDefinition copyWith({
    int? id,
    String? name,
    String? reportType,
    String? querySql,
    String? paramsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReportDefinition',
      if (id != null) 'id': id,
      'name': name,
      'reportType': reportType,
      if (querySql != null) 'querySql': querySql,
      if (paramsJson != null) 'paramsJson': paramsJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportDefinitionImpl extends ReportDefinition {
  _ReportDefinitionImpl({
    int? id,
    required String name,
    required String reportType,
    String? querySql,
    String? paramsJson,
  }) : super._(
         id: id,
         name: name,
         reportType: reportType,
         querySql: querySql,
         paramsJson: paramsJson,
       );

  /// Returns a shallow copy of this [ReportDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportDefinition copyWith({
    Object? id = _Undefined,
    String? name,
    String? reportType,
    Object? querySql = _Undefined,
    Object? paramsJson = _Undefined,
  }) {
    return ReportDefinition(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      reportType: reportType ?? this.reportType,
      querySql: querySql is String? ? querySql : this.querySql,
      paramsJson: paramsJson is String? ? paramsJson : this.paramsJson,
    );
  }
}
