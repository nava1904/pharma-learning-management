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

abstract class DashboardItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DashboardItem._({
    this.id,
    required this.type,
    this.title,
    this.detail,
    this.dueDate,
    this.value,
    this.count,
    this.status,
  });

  factory DashboardItem({
    String? id,
    required String type,
    String? title,
    String? detail,
    DateTime? dueDate,
    double? value,
    int? count,
    String? status,
  }) = _DashboardItemImpl;

  factory DashboardItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardItem(
      id: jsonSerialization['id'] as String?,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String?,
      detail: jsonSerialization['detail'] as String?,
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      value: (jsonSerialization['value'] as num?)?.toDouble(),
      count: jsonSerialization['count'] as int?,
      status: jsonSerialization['status'] as String?,
    );
  }

  String type;

  String? title;

  String? detail;

  DateTime? dueDate;

  double? value;

  int? count;

  String? status;

  String? id;

  /// Returns a shallow copy of this [DashboardItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardItem copyWith({
    String? id,
    String? type,
    String? title,
    String? detail,
    DateTime? dueDate,
    double? value,
    int? count,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardItem',
      if (id != null) 'id': id,
      'type': type,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (value != null) 'value': value,
      if (count != null) 'count': count,
      if (status != null) 'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardItem',
      if (id != null) 'id': id,
      'type': type,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (value != null) 'value': value,
      if (count != null) 'count': count,
      if (status != null) 'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardItemImpl extends DashboardItem {
  _DashboardItemImpl({
    String? id,
    required String type,
    String? title,
    String? detail,
    DateTime? dueDate,
    double? value,
    int? count,
    String? status,
  }) : super._(
         id: id,
         type: type,
         title: title,
         detail: detail,
         dueDate: dueDate,
         value: value,
         count: count,
         status: status,
       );

  /// Returns a shallow copy of this [DashboardItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardItem copyWith({
    Object? id = _Undefined,
    String? type,
    Object? title = _Undefined,
    Object? detail = _Undefined,
    Object? dueDate = _Undefined,
    Object? value = _Undefined,
    Object? count = _Undefined,
    Object? status = _Undefined,
  }) {
    return DashboardItem(
      id: id is String? ? id : this.id,
      type: type ?? this.type,
      title: title is String? ? title : this.title,
      detail: detail is String? ? detail : this.detail,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      value: value is double? ? value : this.value,
      count: count is int? ? count : this.count,
      status: status is String? ? status : this.status,
    );
  }
}
