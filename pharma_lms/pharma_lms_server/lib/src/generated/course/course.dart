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
import '../organization/user.dart' as _i2;
import '../organization/organization.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Course entity - learning program container.
abstract class Course implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Course._({
    this.id,
    required this.title,
    this.sopNumber,
    this.description,
    String? status,
    this.createdById,
    this.createdBy,
    required this.organizationId,
    this.organization,
    this.customMetadataJson,
    this.previewVideoUrl,
    this.imageUrl,
    this.tags,
    this.publishedAt,
    bool? disableSelfEnrollment,
    this.category,
    bool? featured,
  }) : status = status ?? 'draft',
       disableSelfEnrollment = disableSelfEnrollment ?? false,
       featured = featured ?? false;

  factory Course({
    int? id,
    required String title,
    String? sopNumber,
    String? description,
    String? status,
    int? createdById,
    _i2.PharmaUser? createdBy,
    required int organizationId,
    _i3.Organization? organization,
    String? customMetadataJson,
    String? previewVideoUrl,
    String? imageUrl,
    String? tags,
    DateTime? publishedAt,
    bool? disableSelfEnrollment,
    String? category,
    bool? featured,
  }) = _CourseImpl;

  factory Course.fromJson(Map<String, dynamic> jsonSerialization) {
    return Course(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      sopNumber: jsonSerialization['sopNumber'] as String?,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as String?,
      createdById: jsonSerialization['createdById'] as int?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['organization'],
            ),
      customMetadataJson: jsonSerialization['customMetadataJson'] as String?,
      previewVideoUrl: jsonSerialization['previewVideoUrl'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      tags: jsonSerialization['tags'] as String?,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      disableSelfEnrollment: jsonSerialization['disableSelfEnrollment'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['disableSelfEnrollment'],
            ),
      category: jsonSerialization['category'] as String?,
      featured: jsonSerialization['featured'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['featured']),
    );
  }

  static final t = CourseTable();

  static const db = CourseRepository._();

  @override
  int? id;

  /// Course title.
  String title;

  /// SOP number if linked to SOP (e.g., SOP-105).
  String? sopNumber;

  /// Description.
  String? description;

  /// Status: draft, pending_qa, approved, archived.
  String status;

  int? createdById;

  /// User who created the course.
  _i2.PharmaUser? createdBy;

  int organizationId;

  /// Organization for multi-tenant.
  _i3.Organization? organization;

  /// Site-specific JSON attributes (curricula tags, therapeutic area, etc.).
  String? customMetadataJson;

  /// Preview/teaser video URL (YouTube, Vimeo, etc.).
  String? previewVideoUrl;

  /// Cover image URL for the course.
  String? imageUrl;

  /// Comma-separated tags (difficulty, therapeutic area, etc.).
  String? tags;

  /// Date the course was published.
  DateTime? publishedAt;

  /// Whether self-enrollment is disabled (admin/manager assignment only).
  bool disableSelfEnrollment;

  /// Course category (e.g., GMP, Quality, Safety).
  String? category;

  /// Whether this course is featured/promoted.
  bool featured;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Course copyWith({
    int? id,
    String? title,
    String? sopNumber,
    String? description,
    String? status,
    int? createdById,
    _i2.PharmaUser? createdBy,
    int? organizationId,
    _i3.Organization? organization,
    String? customMetadataJson,
    String? previewVideoUrl,
    String? imageUrl,
    String? tags,
    DateTime? publishedAt,
    bool? disableSelfEnrollment,
    String? category,
    bool? featured,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Course',
      if (id != null) 'id': id,
      'title': title,
      if (sopNumber != null) 'sopNumber': sopNumber,
      if (description != null) 'description': description,
      'status': status,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (customMetadataJson != null) 'customMetadataJson': customMetadataJson,
      if (previewVideoUrl != null) 'previewVideoUrl': previewVideoUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (tags != null) 'tags': tags,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'disableSelfEnrollment': disableSelfEnrollment,
      if (category != null) 'category': category,
      'featured': featured,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Course',
      if (id != null) 'id': id,
      'title': title,
      if (sopNumber != null) 'sopNumber': sopNumber,
      if (description != null) 'description': description,
      'status': status,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJsonForProtocol(),
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      if (customMetadataJson != null) 'customMetadataJson': customMetadataJson,
      if (previewVideoUrl != null) 'previewVideoUrl': previewVideoUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (tags != null) 'tags': tags,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'disableSelfEnrollment': disableSelfEnrollment,
      if (category != null) 'category': category,
      'featured': featured,
    };
  }

  static CourseInclude include({
    _i2.PharmaUserInclude? createdBy,
    _i3.OrganizationInclude? organization,
  }) {
    return CourseInclude._(
      createdBy: createdBy,
      organization: organization,
    );
  }

  static CourseIncludeList includeList({
    _i1.WhereExpressionBuilder<CourseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseTable>? orderByList,
    CourseInclude? include,
  }) {
    return CourseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Course.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Course.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseImpl extends Course {
  _CourseImpl({
    int? id,
    required String title,
    String? sopNumber,
    String? description,
    String? status,
    int? createdById,
    _i2.PharmaUser? createdBy,
    required int organizationId,
    _i3.Organization? organization,
    String? customMetadataJson,
    String? previewVideoUrl,
    String? imageUrl,
    String? tags,
    DateTime? publishedAt,
    bool? disableSelfEnrollment,
    String? category,
    bool? featured,
  }) : super._(
         id: id,
         title: title,
         sopNumber: sopNumber,
         description: description,
         status: status,
         createdById: createdById,
         createdBy: createdBy,
         organizationId: organizationId,
         organization: organization,
         customMetadataJson: customMetadataJson,
         previewVideoUrl: previewVideoUrl,
         imageUrl: imageUrl,
         tags: tags,
         publishedAt: publishedAt,
         disableSelfEnrollment: disableSelfEnrollment,
         category: category,
         featured: featured,
       );

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Course copyWith({
    Object? id = _Undefined,
    String? title,
    Object? sopNumber = _Undefined,
    Object? description = _Undefined,
    String? status,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    Object? customMetadataJson = _Undefined,
    Object? previewVideoUrl = _Undefined,
    Object? imageUrl = _Undefined,
    Object? tags = _Undefined,
    Object? publishedAt = _Undefined,
    bool? disableSelfEnrollment,
    Object? category = _Undefined,
    bool? featured,
  }) {
    return Course(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      sopNumber: sopNumber is String? ? sopNumber : this.sopNumber,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i2.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i3.Organization?
          ? organization
          : this.organization?.copyWith(),
      customMetadataJson: customMetadataJson is String?
          ? customMetadataJson
          : this.customMetadataJson,
      previewVideoUrl: previewVideoUrl is String?
          ? previewVideoUrl
          : this.previewVideoUrl,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      tags: tags is String? ? tags : this.tags,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      disableSelfEnrollment:
          disableSelfEnrollment ?? this.disableSelfEnrollment,
      category: category is String? ? category : this.category,
      featured: featured ?? this.featured,
    );
  }
}

class CourseUpdateTable extends _i1.UpdateTable<CourseTable> {
  CourseUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> sopNumber(String? value) => _i1.ColumnValue(
    table.sopNumber,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> createdById(int? value) => _i1.ColumnValue(
    table.createdById,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> customMetadataJson(String? value) =>
      _i1.ColumnValue(
        table.customMetadataJson,
        value,
      );

  _i1.ColumnValue<String, String> previewVideoUrl(String? value) =>
      _i1.ColumnValue(
        table.previewVideoUrl,
        value,
      );

  _i1.ColumnValue<String, String> imageUrl(String? value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<String, String> tags(String? value) => _i1.ColumnValue(
    table.tags,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.publishedAt,
        value,
      );

  _i1.ColumnValue<bool, bool> disableSelfEnrollment(bool value) =>
      _i1.ColumnValue(
        table.disableSelfEnrollment,
        value,
      );

  _i1.ColumnValue<String, String> category(String? value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<bool, bool> featured(bool value) => _i1.ColumnValue(
    table.featured,
    value,
  );
}

class CourseTable extends _i1.Table<int?> {
  CourseTable({super.tableRelation}) : super(tableName: 'course') {
    updateTable = CourseUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    sopNumber = _i1.ColumnString(
      'sopNumber',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdById = _i1.ColumnInt(
      'createdById',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    customMetadataJson = _i1.ColumnString(
      'customMetadataJson',
      this,
    );
    previewVideoUrl = _i1.ColumnString(
      'previewVideoUrl',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    tags = _i1.ColumnString(
      'tags',
      this,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
      this,
    );
    disableSelfEnrollment = _i1.ColumnBool(
      'disableSelfEnrollment',
      this,
      hasDefault: true,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    featured = _i1.ColumnBool(
      'featured',
      this,
      hasDefault: true,
    );
  }

  late final CourseUpdateTable updateTable;

  /// Course title.
  late final _i1.ColumnString title;

  /// SOP number if linked to SOP (e.g., SOP-105).
  late final _i1.ColumnString sopNumber;

  /// Description.
  late final _i1.ColumnString description;

  /// Status: draft, pending_qa, approved, archived.
  late final _i1.ColumnString status;

  late final _i1.ColumnInt createdById;

  /// User who created the course.
  _i2.PharmaUserTable? _createdBy;

  late final _i1.ColumnInt organizationId;

  /// Organization for multi-tenant.
  _i3.OrganizationTable? _organization;

  /// Site-specific JSON attributes (curricula tags, therapeutic area, etc.).
  late final _i1.ColumnString customMetadataJson;

  /// Preview/teaser video URL (YouTube, Vimeo, etc.).
  late final _i1.ColumnString previewVideoUrl;

  /// Cover image URL for the course.
  late final _i1.ColumnString imageUrl;

  /// Comma-separated tags (difficulty, therapeutic area, etc.).
  late final _i1.ColumnString tags;

  /// Date the course was published.
  late final _i1.ColumnDateTime publishedAt;

  /// Whether self-enrollment is disabled (admin/manager assignment only).
  late final _i1.ColumnBool disableSelfEnrollment;

  /// Course category (e.g., GMP, Quality, Safety).
  late final _i1.ColumnString category;

  /// Whether this course is featured/promoted.
  late final _i1.ColumnBool featured;

  _i2.PharmaUserTable get createdBy {
    if (_createdBy != null) return _createdBy!;
    _createdBy = _i1.createRelationTable(
      relationFieldName: 'createdBy',
      field: Course.t.createdById,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _createdBy!;
  }

  _i3.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Course.t.organizationId,
      foreignField: _i3.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    sopNumber,
    description,
    status,
    createdById,
    organizationId,
    customMetadataJson,
    previewVideoUrl,
    imageUrl,
    tags,
    publishedAt,
    disableSelfEnrollment,
    category,
    featured,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'createdBy') {
      return createdBy;
    }
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class CourseInclude extends _i1.IncludeObject {
  CourseInclude._({
    _i2.PharmaUserInclude? createdBy,
    _i3.OrganizationInclude? organization,
  }) {
    _createdBy = createdBy;
    _organization = organization;
  }

  _i2.PharmaUserInclude? _createdBy;

  _i3.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {
    'createdBy': _createdBy,
    'organization': _organization,
  };

  @override
  _i1.Table<int?> get table => Course.t;
}

class CourseIncludeList extends _i1.IncludeList {
  CourseIncludeList._({
    _i1.WhereExpressionBuilder<CourseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Course.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Course.t;
}

class CourseRepository {
  const CourseRepository._();

  final attachRow = const CourseAttachRowRepository._();

  final detachRow = const CourseDetachRowRepository._();

  /// Returns a list of [Course]s matching the given query parameters.
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
  Future<List<Course>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseTable>? orderByList,
    _i1.Transaction? transaction,
    CourseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Course>(
      where: where?.call(Course.t),
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Course] matching the given query parameters.
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
  Future<Course?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseTable>? where,
    int? offset,
    _i1.OrderByBuilder<CourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseTable>? orderByList,
    _i1.Transaction? transaction,
    CourseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Course>(
      where: where?.call(Course.t),
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Course] by its [id] or null if no such row exists.
  Future<Course?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    CourseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Course>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Course]s in the list and returns the inserted rows.
  ///
  /// The returned [Course]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Course>> insert(
    _i1.DatabaseSession session,
    List<Course> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Course>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Course] and returns the inserted row.
  ///
  /// The returned [Course] will have its `id` field set.
  Future<Course> insertRow(
    _i1.DatabaseSession session,
    Course row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Course>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Course]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Course>> update(
    _i1.DatabaseSession session,
    List<Course> rows, {
    _i1.ColumnSelections<CourseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Course>(
      rows,
      columns: columns?.call(Course.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Course]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Course> updateRow(
    _i1.DatabaseSession session,
    Course row, {
    _i1.ColumnSelections<CourseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Course>(
      row,
      columns: columns?.call(Course.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Course] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Course?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CourseUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Course>(
      id,
      columnValues: columnValues(Course.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Course]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Course>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CourseUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CourseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseTable>? orderBy,
    _i1.OrderByListBuilder<CourseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Course>(
      columnValues: columnValues(Course.t.updateTable),
      where: where(Course.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Course]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Course>> delete(
    _i1.DatabaseSession session,
    List<Course> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Course>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Course].
  Future<Course> deleteRow(
    _i1.DatabaseSession session,
    Course row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Course>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Course>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Course>(
      where: where(Course.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Course>(
      where: where?.call(Course.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Course] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Course>(
      where: where(Course.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CourseAttachRowRepository {
  const CourseAttachRowRepository._();

  /// Creates a relation between the given [Course] and [PharmaUser]
  /// by setting the [Course]'s foreign key `createdById` to refer to the [PharmaUser].
  Future<void> createdBy(
    _i1.DatabaseSession session,
    Course course,
    _i2.PharmaUser createdBy, {
    _i1.Transaction? transaction,
  }) async {
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }
    if (createdBy.id == null) {
      throw ArgumentError.notNull('createdBy.id');
    }

    var $course = course.copyWith(createdById: createdBy.id);
    await session.db.updateRow<Course>(
      $course,
      columns: [Course.t.createdById],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Course] and [Organization]
  /// by setting the [Course]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    Course course,
    _i3.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $course = course.copyWith(organizationId: organization.id);
    await session.db.updateRow<Course>(
      $course,
      columns: [Course.t.organizationId],
      transaction: transaction,
    );
  }
}

class CourseDetachRowRepository {
  const CourseDetachRowRepository._();

  /// Detaches the relation between this [Course] and the [PharmaUser] set in `createdBy`
  /// by setting the [Course]'s foreign key `createdById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> createdBy(
    _i1.DatabaseSession session,
    Course course, {
    _i1.Transaction? transaction,
  }) async {
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }

    var $course = course.copyWith(createdById: null);
    await session.db.updateRow<Course>(
      $course,
      columns: [Course.t.createdById],
      transaction: transaction,
    );
  }
}
