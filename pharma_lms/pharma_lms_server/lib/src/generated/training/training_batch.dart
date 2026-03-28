/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../organization/organization.dart' as _i2;
import '../course/course_version.dart' as _i3;
import '../organization/user.dart' as _i4;
import '../organization/facility.dart' as _i5;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i6;

/// Training batch for scheduled cohort training. GMP compliant.
abstract class TrainingBatch
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingBatch._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.courseVersionId,
    this.courseVersion,
    required this.name,
    required this.instructorId,
    this.instructor,
    required this.startDate,
    required this.endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    this.location,
    this.notes,
    DateTime? createdAt,
    this.facilityId,
    this.facility,
    this.startTime,
    this.endTime,
    this.medium,
    this.meetingUrl,
    this.category,
    this.description,
  }) : capacity = capacity ?? 30,
       enrolledCount = enrolledCount ?? 0,
       completedCount = completedCount ?? 0,
       status = status ?? 'scheduled',
       createdAt = createdAt ?? DateTime.now();

  factory TrainingBatch({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required String name,
    required int instructorId,
    _i4.PharmaUser? instructor,
    required DateTime startDate,
    required DateTime endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    String? location,
    String? notes,
    DateTime? createdAt,
    int? facilityId,
    _i5.Facility? facility,
    String? startTime,
    String? endTime,
    String? medium,
    String? meetingUrl,
    String? category,
    String? description,
  }) = _TrainingBatchImpl;

  factory TrainingBatch.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingBatch(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      name: jsonSerialization['name'] as String,
      instructorId: jsonSerialization['instructorId'] as int,
      instructor: jsonSerialization['instructor'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['instructor'],
            ),
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      capacity: jsonSerialization['capacity'] as int?,
      enrolledCount: jsonSerialization['enrolledCount'] as int?,
      completedCount: jsonSerialization['completedCount'] as int?,
      status: jsonSerialization['status'] as String?,
      location: jsonSerialization['location'] as String?,
      notes: jsonSerialization['notes'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      facilityId: jsonSerialization['facilityId'] as int?,
      facility: jsonSerialization['facility'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.Facility>(
              jsonSerialization['facility'],
            ),
      startTime: jsonSerialization['startTime'] as String?,
      endTime: jsonSerialization['endTime'] as String?,
      medium: jsonSerialization['medium'] as String?,
      meetingUrl: jsonSerialization['meetingUrl'] as String?,
      category: jsonSerialization['category'] as String?,
      description: jsonSerialization['description'] as String?,
    );
  }

  static final t = TrainingBatchTable();

  static const db = TrainingBatchRepository._();

  @override
  int? id;

  int organizationId;

  /// Organization this batch belongs to.
  _i2.Organization? organization;

  int courseVersionId;

  /// The course version for this batch.
  _i3.CourseVersion? courseVersion;

  /// Batch name.
  String name;

  int instructorId;

  /// Instructor/trainer assigned.
  _i4.PharmaUser? instructor;

  /// When batch starts.
  DateTime startDate;

  /// When batch ends.
  DateTime endDate;

  /// Max capacity of learners.
  int capacity;

  /// Number of learners enrolled.
  int enrolledCount;

  /// Number of learners completed.
  int completedCount;

  /// Status: scheduled, active, completed, cancelled.
  String status;

  /// Location (room, building, etc).
  String? location;

  /// Notes or description.
  String? notes;

  /// Created timestamp.
  DateTime createdAt;

  int? facilityId;

  /// Optional validated facility / room (capacity enforcement roadmap).
  _i5.Facility? facility;

  /// Session start time (HH:mm format).
  String? startTime;

  /// Session end time (HH:mm format).
  String? endTime;

  /// Delivery medium: online, offline, hybrid.
  String? medium;

  /// Meeting/conference URL for online/hybrid batches.
  String? meetingUrl;

  /// Batch category.
  String? category;

  /// Long description.
  String? description;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingBatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingBatch copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    String? name,
    int? instructorId,
    _i4.PharmaUser? instructor,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    String? location,
    String? notes,
    DateTime? createdAt,
    int? facilityId,
    _i5.Facility? facility,
    String? startTime,
    String? endTime,
    String? medium,
    String? meetingUrl,
    String? category,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingBatch',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'name': name,
      'instructorId': instructorId,
      if (instructor != null) 'instructor': instructor?.toJson(),
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'capacity': capacity,
      'enrolledCount': enrolledCount,
      'completedCount': completedCount,
      'status': status,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      if (facility != null) 'facility': facility?.toJson(),
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (medium != null) 'medium': medium,
      if (meetingUrl != null) 'meetingUrl': meetingUrl,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingBatch',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'name': name,
      'instructorId': instructorId,
      if (instructor != null) 'instructor': instructor?.toJsonForProtocol(),
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'capacity': capacity,
      'enrolledCount': enrolledCount,
      'completedCount': completedCount,
      'status': status,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      if (facility != null) 'facility': facility?.toJsonForProtocol(),
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (medium != null) 'medium': medium,
      if (meetingUrl != null) 'meetingUrl': meetingUrl,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
    };
  }

  static TrainingBatchInclude include({
    _i2.OrganizationInclude? organization,
    _i3.CourseVersionInclude? courseVersion,
    _i4.PharmaUserInclude? instructor,
    _i5.FacilityInclude? facility,
  }) {
    return TrainingBatchInclude._(
      organization: organization,
      courseVersion: courseVersion,
      instructor: instructor,
      facility: facility,
    );
  }

  static TrainingBatchIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingBatchTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingBatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingBatchTable>? orderByList,
    TrainingBatchInclude? include,
  }) {
    return TrainingBatchIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingBatch.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingBatch.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingBatchImpl extends TrainingBatch {
  _TrainingBatchImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required String name,
    required int instructorId,
    _i4.PharmaUser? instructor,
    required DateTime startDate,
    required DateTime endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    String? location,
    String? notes,
    DateTime? createdAt,
    int? facilityId,
    _i5.Facility? facility,
    String? startTime,
    String? endTime,
    String? medium,
    String? meetingUrl,
    String? category,
    String? description,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         name: name,
         instructorId: instructorId,
         instructor: instructor,
         startDate: startDate,
         endDate: endDate,
         capacity: capacity,
         enrolledCount: enrolledCount,
         completedCount: completedCount,
         status: status,
         location: location,
         notes: notes,
         createdAt: createdAt,
         facilityId: facilityId,
         facility: facility,
         startTime: startTime,
         endTime: endTime,
         medium: medium,
         meetingUrl: meetingUrl,
         category: category,
         description: description,
       );

  /// Returns a shallow copy of this [TrainingBatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingBatch copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    String? name,
    int? instructorId,
    Object? instructor = _Undefined,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    Object? location = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    Object? facilityId = _Undefined,
    Object? facility = _Undefined,
    Object? startTime = _Undefined,
    Object? endTime = _Undefined,
    Object? medium = _Undefined,
    Object? meetingUrl = _Undefined,
    Object? category = _Undefined,
    Object? description = _Undefined,
  }) {
    return TrainingBatch(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      name: name ?? this.name,
      instructorId: instructorId ?? this.instructorId,
      instructor: instructor is _i4.PharmaUser?
          ? instructor
          : this.instructor?.copyWith(),
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      capacity: capacity ?? this.capacity,
      enrolledCount: enrolledCount ?? this.enrolledCount,
      completedCount: completedCount ?? this.completedCount,
      status: status ?? this.status,
      location: location is String? ? location : this.location,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      facility: facility is _i5.Facility?
          ? facility
          : this.facility?.copyWith(),
      startTime: startTime is String? ? startTime : this.startTime,
      endTime: endTime is String? ? endTime : this.endTime,
      medium: medium is String? ? medium : this.medium,
      meetingUrl: meetingUrl is String? ? meetingUrl : this.meetingUrl,
      category: category is String? ? category : this.category,
      description: description is String? ? description : this.description,
    );
  }
}

class TrainingBatchUpdateTable extends _i1.UpdateTable<TrainingBatchTable> {
  TrainingBatchUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<int, int> instructorId(int value) => _i1.ColumnValue(
    table.instructorId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startDate(DateTime value) =>
      _i1.ColumnValue(
        table.startDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endDate(DateTime value) =>
      _i1.ColumnValue(
        table.endDate,
        value,
      );

  _i1.ColumnValue<int, int> capacity(int value) => _i1.ColumnValue(
    table.capacity,
    value,
  );

  _i1.ColumnValue<int, int> enrolledCount(int value) => _i1.ColumnValue(
    table.enrolledCount,
    value,
  );

  _i1.ColumnValue<int, int> completedCount(int value) => _i1.ColumnValue(
    table.completedCount,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> location(String? value) => _i1.ColumnValue(
    table.location,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<int, int> facilityId(int? value) => _i1.ColumnValue(
    table.facilityId,
    value,
  );

  _i1.ColumnValue<String, String> startTime(String? value) => _i1.ColumnValue(
    table.startTime,
    value,
  );

  _i1.ColumnValue<String, String> endTime(String? value) => _i1.ColumnValue(
    table.endTime,
    value,
  );

  _i1.ColumnValue<String, String> medium(String? value) => _i1.ColumnValue(
    table.medium,
    value,
  );

  _i1.ColumnValue<String, String> meetingUrl(String? value) => _i1.ColumnValue(
    table.meetingUrl,
    value,
  );

  _i1.ColumnValue<String, String> category(String? value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );
}

class TrainingBatchTable extends _i1.Table<int?> {
  TrainingBatchTable({super.tableRelation})
    : super(tableName: 'training_batch') {
    updateTable = TrainingBatchUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    instructorId = _i1.ColumnInt(
      'instructorId',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    capacity = _i1.ColumnInt(
      'capacity',
      this,
      hasDefault: true,
    );
    enrolledCount = _i1.ColumnInt(
      'enrolledCount',
      this,
      hasDefault: true,
    );
    completedCount = _i1.ColumnInt(
      'completedCount',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    facilityId = _i1.ColumnInt(
      'facilityId',
      this,
    );
    startTime = _i1.ColumnString(
      'startTime',
      this,
    );
    endTime = _i1.ColumnString(
      'endTime',
      this,
    );
    medium = _i1.ColumnString(
      'medium',
      this,
    );
    meetingUrl = _i1.ColumnString(
      'meetingUrl',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
  }

  late final TrainingBatchUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  /// Organization this batch belongs to.
  _i2.OrganizationTable? _organization;

  late final _i1.ColumnInt courseVersionId;

  /// The course version for this batch.
  _i3.CourseVersionTable? _courseVersion;

  /// Batch name.
  late final _i1.ColumnString name;

  late final _i1.ColumnInt instructorId;

  /// Instructor/trainer assigned.
  _i4.PharmaUserTable? _instructor;

  /// When batch starts.
  late final _i1.ColumnDateTime startDate;

  /// When batch ends.
  late final _i1.ColumnDateTime endDate;

  /// Max capacity of learners.
  late final _i1.ColumnInt capacity;

  /// Number of learners enrolled.
  late final _i1.ColumnInt enrolledCount;

  /// Number of learners completed.
  late final _i1.ColumnInt completedCount;

  /// Status: scheduled, active, completed, cancelled.
  late final _i1.ColumnString status;

  /// Location (room, building, etc).
  late final _i1.ColumnString location;

  /// Notes or description.
  late final _i1.ColumnString notes;

  /// Created timestamp.
  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt facilityId;

  /// Optional validated facility / room (capacity enforcement roadmap).
  _i5.FacilityTable? _facility;

  /// Session start time (HH:mm format).
  late final _i1.ColumnString startTime;

  /// Session end time (HH:mm format).
  late final _i1.ColumnString endTime;

  /// Delivery medium: online, offline, hybrid.
  late final _i1.ColumnString medium;

  /// Meeting/conference URL for online/hybrid batches.
  late final _i1.ColumnString meetingUrl;

  /// Batch category.
  late final _i1.ColumnString category;

  /// Long description.
  late final _i1.ColumnString description;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: TrainingBatch.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i3.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: TrainingBatch.t.courseVersionId,
      foreignField: _i3.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i4.PharmaUserTable get instructor {
    if (_instructor != null) return _instructor!;
    _instructor = _i1.createRelationTable(
      relationFieldName: 'instructor',
      field: TrainingBatch.t.instructorId,
      foreignField: _i4.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _instructor!;
  }

  _i5.FacilityTable get facility {
    if (_facility != null) return _facility!;
    _facility = _i1.createRelationTable(
      relationFieldName: 'facility',
      field: TrainingBatch.t.facilityId,
      foreignField: _i5.Facility.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.FacilityTable(tableRelation: foreignTableRelation),
    );
    return _facility!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    organizationId,
    courseVersionId,
    name,
    instructorId,
    startDate,
    endDate,
    capacity,
    enrolledCount,
    completedCount,
    status,
    location,
    notes,
    createdAt,
    facilityId,
    startTime,
    endTime,
    medium,
    meetingUrl,
    category,
    description,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'instructor') {
      return instructor;
    }
    if (relationField == 'facility') {
      return facility;
    }
    return null;
  }
}

class TrainingBatchInclude extends _i1.IncludeObject {
  TrainingBatchInclude._({
    _i2.OrganizationInclude? organization,
    _i3.CourseVersionInclude? courseVersion,
    _i4.PharmaUserInclude? instructor,
    _i5.FacilityInclude? facility,
  }) {
    _organization = organization;
    _courseVersion = courseVersion;
    _instructor = instructor;
    _facility = facility;
  }

  _i2.OrganizationInclude? _organization;

  _i3.CourseVersionInclude? _courseVersion;

  _i4.PharmaUserInclude? _instructor;

  _i5.FacilityInclude? _facility;

  @override
  Map<String, _i1.Include?> get includes => {
    'organization': _organization,
    'courseVersion': _courseVersion,
    'instructor': _instructor,
    'facility': _facility,
  };

  @override
  _i1.Table<int?> get table => TrainingBatch.t;
}

class TrainingBatchIncludeList extends _i1.IncludeList {
  TrainingBatchIncludeList._({
    _i1.WhereExpressionBuilder<TrainingBatchTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingBatch.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingBatch.t;
}

class TrainingBatchRepository {
  const TrainingBatchRepository._();

  final attachRow = const TrainingBatchAttachRowRepository._();

  final detachRow = const TrainingBatchDetachRowRepository._();

  /// Returns a list of [TrainingBatch]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<TrainingBatch>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingBatchTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingBatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingBatchTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingBatchInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingBatch>(
      where: where?.call(TrainingBatch.t),
      orderBy: orderBy?.call(TrainingBatch.t),
      orderByList: orderByList?.call(TrainingBatch.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingBatch] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<TrainingBatch?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingBatchTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingBatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingBatchTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingBatchInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingBatch>(
      where: where?.call(TrainingBatch.t),
      orderBy: orderBy?.call(TrainingBatch.t),
      orderByList: orderByList?.call(TrainingBatch.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingBatch] by its [id] or null if no such row exists.
  Future<TrainingBatch?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingBatchInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingBatch>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingBatch]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingBatch]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingBatch>> insert(
    _i1.DatabaseSession session,
    List<TrainingBatch> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingBatch>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingBatch] and returns the inserted row.
  ///
  /// The returned [TrainingBatch] will have its `id` field set.
  Future<TrainingBatch> insertRow(
    _i1.DatabaseSession session,
    TrainingBatch row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingBatch>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingBatch]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingBatch>> update(
    _i1.DatabaseSession session,
    List<TrainingBatch> rows, {
    _i1.ColumnSelections<TrainingBatchTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingBatch>(
      rows,
      columns: columns?.call(TrainingBatch.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingBatch]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingBatch> updateRow(
    _i1.DatabaseSession session,
    TrainingBatch row, {
    _i1.ColumnSelections<TrainingBatchTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingBatch>(
      row,
      columns: columns?.call(TrainingBatch.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingBatch] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingBatch?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingBatchUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingBatch>(
      id,
      columnValues: columnValues(TrainingBatch.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingBatch]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingBatch>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingBatchUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TrainingBatchTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingBatchTable>? orderBy,
    _i1.OrderByListBuilder<TrainingBatchTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingBatch>(
      columnValues: columnValues(TrainingBatch.t.updateTable),
      where: where(TrainingBatch.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingBatch.t),
      orderByList: orderByList?.call(TrainingBatch.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingBatch]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingBatch>> delete(
    _i1.DatabaseSession session,
    List<TrainingBatch> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingBatch>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingBatch].
  Future<TrainingBatch> deleteRow(
    _i1.DatabaseSession session,
    TrainingBatch row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingBatch>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingBatch>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingBatchTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingBatch>(
      where: where(TrainingBatch.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingBatchTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingBatch>(
      where: where?.call(TrainingBatch.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingBatch] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingBatchTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingBatch>(
      where: where(TrainingBatch.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingBatchAttachRowRepository {
  const TrainingBatchAttachRowRepository._();

  /// Creates a relation between the given [TrainingBatch] and [Organization]
  /// by setting the [TrainingBatch]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    TrainingBatch trainingBatch,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingBatch.id == null) {
      throw ArgumentError.notNull('trainingBatch.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $trainingBatch = trainingBatch.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<TrainingBatch>(
      $trainingBatch,
      columns: [TrainingBatch.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingBatch] and [CourseVersion]
  /// by setting the [TrainingBatch]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    TrainingBatch trainingBatch,
    _i3.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingBatch.id == null) {
      throw ArgumentError.notNull('trainingBatch.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $trainingBatch = trainingBatch.copyWith(
      courseVersionId: courseVersion.id,
    );
    await session.db.updateRow<TrainingBatch>(
      $trainingBatch,
      columns: [TrainingBatch.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingBatch] and [PharmaUser]
  /// by setting the [TrainingBatch]'s foreign key `instructorId` to refer to the [PharmaUser].
  Future<void> instructor(
    _i1.DatabaseSession session,
    TrainingBatch trainingBatch,
    _i4.PharmaUser instructor, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingBatch.id == null) {
      throw ArgumentError.notNull('trainingBatch.id');
    }
    if (instructor.id == null) {
      throw ArgumentError.notNull('instructor.id');
    }

    var $trainingBatch = trainingBatch.copyWith(instructorId: instructor.id);
    await session.db.updateRow<TrainingBatch>(
      $trainingBatch,
      columns: [TrainingBatch.t.instructorId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingBatch] and [Facility]
  /// by setting the [TrainingBatch]'s foreign key `facilityId` to refer to the [Facility].
  Future<void> facility(
    _i1.DatabaseSession session,
    TrainingBatch trainingBatch,
    _i5.Facility facility, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingBatch.id == null) {
      throw ArgumentError.notNull('trainingBatch.id');
    }
    if (facility.id == null) {
      throw ArgumentError.notNull('facility.id');
    }

    var $trainingBatch = trainingBatch.copyWith(facilityId: facility.id);
    await session.db.updateRow<TrainingBatch>(
      $trainingBatch,
      columns: [TrainingBatch.t.facilityId],
      transaction: transaction,
    );
  }
}

class TrainingBatchDetachRowRepository {
  const TrainingBatchDetachRowRepository._();

  /// Detaches the relation between this [TrainingBatch] and the [Facility] set in `facility`
  /// by setting the [TrainingBatch]'s foreign key `facilityId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> facility(
    _i1.DatabaseSession session,
    TrainingBatch trainingBatch, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingBatch.id == null) {
      throw ArgumentError.notNull('trainingBatch.id');
    }

    var $trainingBatch = trainingBatch.copyWith(facilityId: null);
    await session.db.updateRow<TrainingBatch>(
      $trainingBatch,
      columns: [TrainingBatch.t.facilityId],
      transaction: transaction,
    );
  }
}
