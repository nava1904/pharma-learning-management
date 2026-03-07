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
import '../organization/organization.dart' as _i2;
import '../organization/site.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Inspection report (FDA, etc.).
abstract class InspectionReport implements _i1.SerializableModel {
  InspectionReport._({
    this.id,
    required this.organizationId,
    this.organization,
    this.siteId,
    this.site,
    this.inspector,
    this.inspectionDate,
    this.findingsJson,
    required this.status,
  });

  factory InspectionReport({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    int? siteId,
    _i3.Site? site,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
    required String status,
  }) = _InspectionReportImpl;

  factory InspectionReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return InspectionReport(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      siteId: jsonSerialization['siteId'] as int?,
      site: jsonSerialization['site'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Site>(jsonSerialization['site']),
      inspector: jsonSerialization['inspector'] as String?,
      inspectionDate: jsonSerialization['inspectionDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['inspectionDate'],
            ),
      findingsJson: jsonSerialization['findingsJson'] as String?,
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  /// Organization.
  _i2.Organization? organization;

  int? siteId;

  /// Site inspected.
  _i3.Site? site;

  /// Inspector name/agency.
  String? inspector;

  /// Inspection date.
  DateTime? inspectionDate;

  /// Findings as JSON.
  String? findingsJson;

  /// Status.
  String status;

  /// Returns a shallow copy of this [InspectionReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InspectionReport copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    int? siteId,
    _i3.Site? site,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InspectionReport',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      if (inspector != null) 'inspector': inspector,
      if (inspectionDate != null) 'inspectionDate': inspectionDate?.toJson(),
      if (findingsJson != null) 'findingsJson': findingsJson,
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InspectionReportImpl extends InspectionReport {
  _InspectionReportImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    int? siteId,
    _i3.Site? site,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
    required String status,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         siteId: siteId,
         site: site,
         inspector: inspector,
         inspectionDate: inspectionDate,
         findingsJson: findingsJson,
         status: status,
       );

  /// Returns a shallow copy of this [InspectionReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InspectionReport copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    Object? siteId = _Undefined,
    Object? site = _Undefined,
    Object? inspector = _Undefined,
    Object? inspectionDate = _Undefined,
    Object? findingsJson = _Undefined,
    String? status,
  }) {
    return InspectionReport(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      siteId: siteId is int? ? siteId : this.siteId,
      site: site is _i3.Site? ? site : this.site?.copyWith(),
      inspector: inspector is String? ? inspector : this.inspector,
      inspectionDate: inspectionDate is DateTime?
          ? inspectionDate
          : this.inspectionDate,
      findingsJson: findingsJson is String? ? findingsJson : this.findingsJson,
      status: status ?? this.status,
    );
  }
}
