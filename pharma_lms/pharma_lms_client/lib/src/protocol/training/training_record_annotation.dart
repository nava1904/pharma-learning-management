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
import '../training/training_record.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// QA annotation on a training record.
abstract class TrainingRecordAnnotation implements _i1.SerializableModel {
  TrainingRecordAnnotation._({
    this.id,
    required this.trainingRecordId,
    this.trainingRecord,
    required this.authorId,
    this.author,
    required this.note,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory TrainingRecordAnnotation({
    int? id,
    required int trainingRecordId,
    _i2.TrainingRecord? trainingRecord,
    required int authorId,
    _i3.PharmaUser? author,
    required String note,
    DateTime? createdAt,
  }) = _TrainingRecordAnnotationImpl;

  factory TrainingRecordAnnotation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingRecordAnnotation(
      id: jsonSerialization['id'] as int?,
      trainingRecordId: jsonSerialization['trainingRecordId'] as int,
      trainingRecord: jsonSerialization['trainingRecord'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TrainingRecord>(
              jsonSerialization['trainingRecord'],
            ),
      authorId: jsonSerialization['authorId'] as int,
      author: jsonSerialization['author'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['author'],
            ),
      note: jsonSerialization['note'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int trainingRecordId;

  /// The training record.
  _i2.TrainingRecord? trainingRecord;

  int authorId;

  /// Author (QA user who added the note).
  _i3.PharmaUser? author;

  /// Note text.
  String note;

  /// When created.
  DateTime createdAt;

  /// Returns a shallow copy of this [TrainingRecordAnnotation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingRecordAnnotation copyWith({
    int? id,
    int? trainingRecordId,
    _i2.TrainingRecord? trainingRecord,
    int? authorId,
    _i3.PharmaUser? author,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingRecordAnnotation',
      if (id != null) 'id': id,
      'trainingRecordId': trainingRecordId,
      if (trainingRecord != null) 'trainingRecord': trainingRecord?.toJson(),
      'authorId': authorId,
      if (author != null) 'author': author?.toJson(),
      'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingRecordAnnotationImpl extends TrainingRecordAnnotation {
  _TrainingRecordAnnotationImpl({
    int? id,
    required int trainingRecordId,
    _i2.TrainingRecord? trainingRecord,
    required int authorId,
    _i3.PharmaUser? author,
    required String note,
    DateTime? createdAt,
  }) : super._(
         id: id,
         trainingRecordId: trainingRecordId,
         trainingRecord: trainingRecord,
         authorId: authorId,
         author: author,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [TrainingRecordAnnotation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingRecordAnnotation copyWith({
    Object? id = _Undefined,
    int? trainingRecordId,
    Object? trainingRecord = _Undefined,
    int? authorId,
    Object? author = _Undefined,
    String? note,
    DateTime? createdAt,
  }) {
    return TrainingRecordAnnotation(
      id: id is int? ? id : this.id,
      trainingRecordId: trainingRecordId ?? this.trainingRecordId,
      trainingRecord: trainingRecord is _i2.TrainingRecord?
          ? trainingRecord
          : this.trainingRecord?.copyWith(),
      authorId: authorId ?? this.authorId,
      author: author is _i3.PharmaUser? ? author : this.author?.copyWith(),
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
