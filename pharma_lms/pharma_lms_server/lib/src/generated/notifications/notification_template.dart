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
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Notification template for system notifications. GMP compliant.
abstract class NotificationTemplate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  NotificationTemplate._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.type,
    String? channel,
    this.triggerEvent,
    this.subject,
    required this.bodyTemplate,
    String? status,
    required this.createdById,
    this.createdBy,
    DateTime? createdAt,
    this.updatedAt,
  }) : channel = channel ?? 'email',
       status = status ?? 'draft',
       createdAt = createdAt ?? DateTime.now();

  factory NotificationTemplate({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String type,
    String? channel,
    String? triggerEvent,
    String? subject,
    required String bodyTemplate,
    String? status,
    required int createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NotificationTemplateImpl;

  factory NotificationTemplate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return NotificationTemplate(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      channel: jsonSerialization['channel'] as String?,
      triggerEvent: jsonSerialization['triggerEvent'] as String?,
      subject: jsonSerialization['subject'] as String?,
      bodyTemplate: jsonSerialization['bodyTemplate'] as String,
      status: jsonSerialization['status'] as String?,
      createdById: jsonSerialization['createdById'] as int,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = NotificationTemplateTable();

  static const db = NotificationTemplateRepository._();

  @override
  int? id;

  int organizationId;

  /// Organization this template belongs to.
  _i2.Organization? organization;

  /// Template name/title.
  String name;

  /// Type: assignment, reminder, overdue, certificate, compliance, broadcast.
  String type;

  /// Channel: email, push, sms, in_app.
  String channel;

  /// Trigger event or condition description.
  String? triggerEvent;

  /// Subject line (for email).
  String? subject;

  /// Template body content with variables like {{userName}}, {{courseTitle}}, {{dueDate}}.
  String bodyTemplate;

  /// Status: active, draft, inactive.
  String status;

  int createdById;

  /// Created by user.
  _i3.PharmaUser? createdBy;

  /// Created timestamp.
  DateTime createdAt;

  /// Last updated timestamp.
  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [NotificationTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotificationTemplate copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? type,
    String? channel,
    String? triggerEvent,
    String? subject,
    String? bodyTemplate,
    String? status,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationTemplate',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'type': type,
      'channel': channel,
      if (triggerEvent != null) 'triggerEvent': triggerEvent,
      if (subject != null) 'subject': subject,
      'bodyTemplate': bodyTemplate,
      'status': status,
      'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NotificationTemplate',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'name': name,
      'type': type,
      'channel': channel,
      if (triggerEvent != null) 'triggerEvent': triggerEvent,
      if (subject != null) 'subject': subject,
      'bodyTemplate': bodyTemplate,
      'status': status,
      'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static NotificationTemplateInclude include({
    _i2.OrganizationInclude? organization,
    _i3.PharmaUserInclude? createdBy,
  }) {
    return NotificationTemplateInclude._(
      organization: organization,
      createdBy: createdBy,
    );
  }

  static NotificationTemplateIncludeList includeList({
    _i1.WhereExpressionBuilder<NotificationTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTemplateTable>? orderByList,
    NotificationTemplateInclude? include,
  }) {
    return NotificationTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NotificationTemplate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(NotificationTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationTemplateImpl extends NotificationTemplate {
  _NotificationTemplateImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String type,
    String? channel,
    String? triggerEvent,
    String? subject,
    required String bodyTemplate,
    String? status,
    required int createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         type: type,
         channel: channel,
         triggerEvent: triggerEvent,
         subject: subject,
         bodyTemplate: bodyTemplate,
         status: status,
         createdById: createdById,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [NotificationTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotificationTemplate copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? type,
    String? channel,
    Object? triggerEvent = _Undefined,
    Object? subject = _Undefined,
    String? bodyTemplate,
    String? status,
    int? createdById,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
  }) {
    return NotificationTemplate(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      type: type ?? this.type,
      channel: channel ?? this.channel,
      triggerEvent: triggerEvent is String? ? triggerEvent : this.triggerEvent,
      subject: subject is String? ? subject : this.subject,
      bodyTemplate: bodyTemplate ?? this.bodyTemplate,
      status: status ?? this.status,
      createdById: createdById ?? this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class NotificationTemplateUpdateTable
    extends _i1.UpdateTable<NotificationTemplateTable> {
  NotificationTemplateUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> type(String value) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<String, String> channel(String value) => _i1.ColumnValue(
    table.channel,
    value,
  );

  _i1.ColumnValue<String, String> triggerEvent(String? value) =>
      _i1.ColumnValue(
        table.triggerEvent,
        value,
      );

  _i1.ColumnValue<String, String> subject(String? value) => _i1.ColumnValue(
    table.subject,
    value,
  );

  _i1.ColumnValue<String, String> bodyTemplate(String value) => _i1.ColumnValue(
    table.bodyTemplate,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> createdById(int value) => _i1.ColumnValue(
    table.createdById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class NotificationTemplateTable extends _i1.Table<int?> {
  NotificationTemplateTable({super.tableRelation})
    : super(tableName: 'notification_template') {
    updateTable = NotificationTemplateUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    channel = _i1.ColumnString(
      'channel',
      this,
      hasDefault: true,
    );
    triggerEvent = _i1.ColumnString(
      'triggerEvent',
      this,
    );
    subject = _i1.ColumnString(
      'subject',
      this,
    );
    bodyTemplate = _i1.ColumnString(
      'bodyTemplate',
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
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final NotificationTemplateUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  /// Organization this template belongs to.
  _i2.OrganizationTable? _organization;

  /// Template name/title.
  late final _i1.ColumnString name;

  /// Type: assignment, reminder, overdue, certificate, compliance, broadcast.
  late final _i1.ColumnString type;

  /// Channel: email, push, sms, in_app.
  late final _i1.ColumnString channel;

  /// Trigger event or condition description.
  late final _i1.ColumnString triggerEvent;

  /// Subject line (for email).
  late final _i1.ColumnString subject;

  /// Template body content with variables like {{userName}}, {{courseTitle}}, {{dueDate}}.
  late final _i1.ColumnString bodyTemplate;

  /// Status: active, draft, inactive.
  late final _i1.ColumnString status;

  late final _i1.ColumnInt createdById;

  /// Created by user.
  _i3.PharmaUserTable? _createdBy;

  /// Created timestamp.
  late final _i1.ColumnDateTime createdAt;

  /// Last updated timestamp.
  late final _i1.ColumnDateTime updatedAt;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: NotificationTemplate.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i3.PharmaUserTable get createdBy {
    if (_createdBy != null) return _createdBy!;
    _createdBy = _i1.createRelationTable(
      relationFieldName: 'createdBy',
      field: NotificationTemplate.t.createdById,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _createdBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    organizationId,
    name,
    type,
    channel,
    triggerEvent,
    subject,
    bodyTemplate,
    status,
    createdById,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'createdBy') {
      return createdBy;
    }
    return null;
  }
}

class NotificationTemplateInclude extends _i1.IncludeObject {
  NotificationTemplateInclude._({
    _i2.OrganizationInclude? organization,
    _i3.PharmaUserInclude? createdBy,
  }) {
    _organization = organization;
    _createdBy = createdBy;
  }

  _i2.OrganizationInclude? _organization;

  _i3.PharmaUserInclude? _createdBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'organization': _organization,
    'createdBy': _createdBy,
  };

  @override
  _i1.Table<int?> get table => NotificationTemplate.t;
}

class NotificationTemplateIncludeList extends _i1.IncludeList {
  NotificationTemplateIncludeList._({
    _i1.WhereExpressionBuilder<NotificationTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NotificationTemplate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => NotificationTemplate.t;
}

class NotificationTemplateRepository {
  const NotificationTemplateRepository._();

  final attachRow = const NotificationTemplateAttachRowRepository._();

  /// Returns a list of [NotificationTemplate]s matching the given query parameters.
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
  Future<List<NotificationTemplate>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<NotificationTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTemplateTable>? orderByList,
    _i1.Transaction? transaction,
    NotificationTemplateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<NotificationTemplate>(
      where: where?.call(NotificationTemplate.t),
      orderBy: orderBy?.call(NotificationTemplate.t),
      orderByList: orderByList?.call(NotificationTemplate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [NotificationTemplate] matching the given query parameters.
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
  Future<NotificationTemplate?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<NotificationTemplateTable>? where,
    int? offset,
    _i1.OrderByBuilder<NotificationTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTemplateTable>? orderByList,
    _i1.Transaction? transaction,
    NotificationTemplateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<NotificationTemplate>(
      where: where?.call(NotificationTemplate.t),
      orderBy: orderBy?.call(NotificationTemplate.t),
      orderByList: orderByList?.call(NotificationTemplate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [NotificationTemplate] by its [id] or null if no such row exists.
  Future<NotificationTemplate?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    NotificationTemplateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<NotificationTemplate>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [NotificationTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [NotificationTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<NotificationTemplate>> insert(
    _i1.DatabaseSession session,
    List<NotificationTemplate> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<NotificationTemplate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [NotificationTemplate] and returns the inserted row.
  ///
  /// The returned [NotificationTemplate] will have its `id` field set.
  Future<NotificationTemplate> insertRow(
    _i1.DatabaseSession session,
    NotificationTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<NotificationTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [NotificationTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<NotificationTemplate>> update(
    _i1.DatabaseSession session,
    List<NotificationTemplate> rows, {
    _i1.ColumnSelections<NotificationTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<NotificationTemplate>(
      rows,
      columns: columns?.call(NotificationTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NotificationTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NotificationTemplate> updateRow(
    _i1.DatabaseSession session,
    NotificationTemplate row, {
    _i1.ColumnSelections<NotificationTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<NotificationTemplate>(
      row,
      columns: columns?.call(NotificationTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NotificationTemplate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<NotificationTemplate?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<NotificationTemplateUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<NotificationTemplate>(
      id,
      columnValues: columnValues(NotificationTemplate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [NotificationTemplate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<NotificationTemplate>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<NotificationTemplateUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<NotificationTemplateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTemplateTable>? orderBy,
    _i1.OrderByListBuilder<NotificationTemplateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<NotificationTemplate>(
      columnValues: columnValues(NotificationTemplate.t.updateTable),
      where: where(NotificationTemplate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NotificationTemplate.t),
      orderByList: orderByList?.call(NotificationTemplate.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [NotificationTemplate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<NotificationTemplate>> delete(
    _i1.DatabaseSession session,
    List<NotificationTemplate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<NotificationTemplate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [NotificationTemplate].
  Future<NotificationTemplate> deleteRow(
    _i1.DatabaseSession session,
    NotificationTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NotificationTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<NotificationTemplate>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<NotificationTemplateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<NotificationTemplate>(
      where: where(NotificationTemplate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<NotificationTemplateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<NotificationTemplate>(
      where: where?.call(NotificationTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [NotificationTemplate] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<NotificationTemplateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<NotificationTemplate>(
      where: where(NotificationTemplate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class NotificationTemplateAttachRowRepository {
  const NotificationTemplateAttachRowRepository._();

  /// Creates a relation between the given [NotificationTemplate] and [Organization]
  /// by setting the [NotificationTemplate]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    NotificationTemplate notificationTemplate,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (notificationTemplate.id == null) {
      throw ArgumentError.notNull('notificationTemplate.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $notificationTemplate = notificationTemplate.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<NotificationTemplate>(
      $notificationTemplate,
      columns: [NotificationTemplate.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [NotificationTemplate] and [PharmaUser]
  /// by setting the [NotificationTemplate]'s foreign key `createdById` to refer to the [PharmaUser].
  Future<void> createdBy(
    _i1.DatabaseSession session,
    NotificationTemplate notificationTemplate,
    _i3.PharmaUser createdBy, {
    _i1.Transaction? transaction,
  }) async {
    if (notificationTemplate.id == null) {
      throw ArgumentError.notNull('notificationTemplate.id');
    }
    if (createdBy.id == null) {
      throw ArgumentError.notNull('createdBy.id');
    }

    var $notificationTemplate = notificationTemplate.copyWith(
      createdById: createdBy.id,
    );
    await session.db.updateRow<NotificationTemplate>(
      $notificationTemplate,
      columns: [NotificationTemplate.t.createdById],
      transaction: transaction,
    );
  }
}
