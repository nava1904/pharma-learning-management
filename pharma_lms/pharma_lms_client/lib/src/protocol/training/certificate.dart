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
import '../course/course_version.dart' as _i3;
import '../training/training_record.dart' as _i4;
import '../shared/electronic_signature.dart' as _i5;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i6;

/// Certificate issued after successful training.
abstract class Certificate implements _i1.SerializableModel {
  Certificate._({
    this.id,
    required this.userId,
    this.user,
    required this.courseVersionId,
    this.courseVersion,
    required this.trainingRecordId,
    this.trainingRecord,
    DateTime? issuedAt,
    this.expiresAt,
    this.qrCode,
    required this.esignatureId,
    this.esignature,
  }) : issuedAt = issuedAt ?? DateTime.now();

  factory Certificate({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int trainingRecordId,
    _i4.TrainingRecord? trainingRecord,
    DateTime? issuedAt,
    DateTime? expiresAt,
    String? qrCode,
    required int esignatureId,
    _i5.ElectronicSignature? esignature,
  }) = _CertificateImpl;

  factory Certificate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Certificate(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      trainingRecordId: jsonSerialization['trainingRecordId'] as int,
      trainingRecord: jsonSerialization['trainingRecord'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.TrainingRecord>(
              jsonSerialization['trainingRecord'],
            ),
      issuedAt: jsonSerialization['issuedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['issuedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      qrCode: jsonSerialization['qrCode'] as String?,
      esignatureId: jsonSerialization['esignatureId'] as int,
      esignature: jsonSerialization['esignature'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.ElectronicSignature>(
              jsonSerialization['esignature'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int courseVersionId;

  /// The course version.
  _i3.CourseVersion? courseVersion;

  int trainingRecordId;

  /// The training record.
  _i4.TrainingRecord? trainingRecord;

  /// When issued.
  DateTime issuedAt;

  /// When it expires.
  DateTime? expiresAt;

  /// QR code for verification.
  String? qrCode;

  int esignatureId;

  /// Electronic signature.
  _i5.ElectronicSignature? esignature;

  /// Returns a shallow copy of this [Certificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Certificate copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? trainingRecordId,
    _i4.TrainingRecord? trainingRecord,
    DateTime? issuedAt,
    DateTime? expiresAt,
    String? qrCode,
    int? esignatureId,
    _i5.ElectronicSignature? esignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Certificate',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'trainingRecordId': trainingRecordId,
      if (trainingRecord != null) 'trainingRecord': trainingRecord?.toJson(),
      'issuedAt': issuedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (qrCode != null) 'qrCode': qrCode,
      'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CertificateImpl extends Certificate {
  _CertificateImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int trainingRecordId,
    _i4.TrainingRecord? trainingRecord,
    DateTime? issuedAt,
    DateTime? expiresAt,
    String? qrCode,
    required int esignatureId,
    _i5.ElectronicSignature? esignature,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         trainingRecordId: trainingRecordId,
         trainingRecord: trainingRecord,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         qrCode: qrCode,
         esignatureId: esignatureId,
         esignature: esignature,
       );

  /// Returns a shallow copy of this [Certificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Certificate copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? trainingRecordId,
    Object? trainingRecord = _Undefined,
    DateTime? issuedAt,
    Object? expiresAt = _Undefined,
    Object? qrCode = _Undefined,
    int? esignatureId,
    Object? esignature = _Undefined,
  }) {
    return Certificate(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      trainingRecordId: trainingRecordId ?? this.trainingRecordId,
      trainingRecord: trainingRecord is _i4.TrainingRecord?
          ? trainingRecord
          : this.trainingRecord?.copyWith(),
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      qrCode: qrCode is String? ? qrCode : this.qrCode,
      esignatureId: esignatureId ?? this.esignatureId,
      esignature: esignature is _i5.ElectronicSignature?
          ? esignature
          : this.esignature?.copyWith(),
    );
  }
}
