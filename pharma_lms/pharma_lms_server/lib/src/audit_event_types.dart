/// Central registry of audit event action types for FDA 21 CFR Part 11 compliance.
/// Use these constants when calling AuditService.log to ensure consistent coverage.
///
/// Coverage:
/// - ReportExport, TrainingAssigned, AssignmentUpdated, AssignmentCancelled,
///   EnrollmentCreated, AssignmentReassigned, AssignmentCompleted
/// - CourseStatusChanged, CourseCreated, CertificateObsoleted, CertificateIssued
/// - WaiverRequested, WaiverApproved, WaiverRejected
/// - UserLocked, UserUnlocked, UserCreated
/// - JobRoleTrainingMatrixUpdated, DocumentQaClassificationUpdated
/// - InspectionRecordCreated, InspectionPackageOfficial
/// - ConfigChanged, MaterialProgressCompleted
/// - TrainingCompleted, CapaStatusChanged
/// - LessonCreated, LessonUpdated, LessonBlockCreated/Updated/Deleted
class AuditEventType {
  AuditEventType._();

  static const reportExport = 'ReportExport';
  static const trainingAssigned = 'TrainingAssigned';
  static const assignmentUpdated = 'AssignmentUpdated';
  static const assignmentCancelled = 'AssignmentCancelled';
  static const enrollmentCreated = 'EnrollmentCreated';
  static const assignmentReassigned = 'AssignmentReassigned';
  static const assignmentCompleted = 'AssignmentCompleted';
  static const courseStatusChanged = 'CourseStatusChanged';
  static const courseCreated = 'CourseCreated';
  static const certificateObsoleted = 'CertificateObsoleted';
  static const certificateIssued = 'CertificateIssued';
  static const waiverRequested = 'WaiverRequested';
  static const waiverApproved = 'WaiverApproved';
  static const waiverRejected = 'WaiverRejected';
  static const userLocked = 'UserLocked';
  static const userUnlocked = 'UserUnlocked';
  static const userCreated = 'UserCreated';
  static const jobRoleTrainingMatrixUpdated = 'JobRoleTrainingMatrixUpdated';
  static const documentQaClassificationUpdated = 'DocumentQaClassificationUpdated';
  static const inspectionRecordCreated = 'InspectionRecordCreated';
  static const inspectionPackageOfficial = 'InspectionPackageOfficial';
  static const configChanged = 'ConfigChanged';
  static const materialProgressCompleted = 'MaterialProgressCompleted';
  static const trainingCompleted = 'TrainingCompleted';
  static const capaStatusChanged = 'CapaStatusChanged';
  static const capaClosed = 'CapaClosed';
  static const capaCreated = 'CapaCreated';
  static const userTerminated = 'UserTerminated';
  static const enrollmentCancelled = 'EnrollmentCancelled';
  static const assignmentSuperseded = 'AssignmentSuperseded';
  static const certificateExpired = 'CertificateExpired';
  static const certificateRenewalAssigned = 'CertificateRenewalAssigned';
  static const complianceSnapshotCreated = 'ComplianceSnapshotCreated';
  static const auditIntegrityCheckPassed = 'AuditIntegrityCheckPassed';
  static const auditIntegrityCheckFailed = 'AuditIntegrityCheckFailed';
  static const notificationEscalation = 'NotificationEscalation';
  static const complianceDropAlert = 'ComplianceDropAlert';
  static const courseReleaseAssigned = 'CourseReleaseAssigned';
  static const departmentTransferCompleted = 'DepartmentTransferCompleted';
  static const lessonCreated = 'LessonCreated';
  static const lessonUpdated = 'LessonUpdated';
  static const lessonBlockUpdated = 'LessonBlockUpdated';
  static const lessonBlockCreated = 'LessonBlockCreated';
  static const lessonBlockDeleted = 'LessonBlockDeleted';

  static const Set<String> known = {
    reportExport,
    trainingAssigned,
    assignmentUpdated,
    assignmentCancelled,
    enrollmentCreated,
    assignmentReassigned,
    assignmentCompleted,
    courseStatusChanged,
    courseCreated,
    certificateObsoleted,
    certificateIssued,
    waiverRequested,
    waiverApproved,
    waiverRejected,
    userLocked,
    userUnlocked,
    userCreated,
    jobRoleTrainingMatrixUpdated,
    documentQaClassificationUpdated,
    inspectionRecordCreated,
    inspectionPackageOfficial,
    configChanged,
    materialProgressCompleted,
    trainingCompleted,
    capaStatusChanged,
    capaClosed,
    capaCreated,
    userTerminated,
    enrollmentCancelled,
    assignmentSuperseded,
    certificateExpired,
    certificateRenewalAssigned,
    complianceSnapshotCreated,
    auditIntegrityCheckPassed,
    auditIntegrityCheckFailed,
    notificationEscalation,
    complianceDropAlert,
    courseReleaseAssigned,
    departmentTransferCompleted,
    lessonCreated,
    lessonUpdated,
    lessonBlockUpdated,
    lessonBlockCreated,
    lessonBlockDeleted,
  };

  /// Returns true if [action] is in the known registry.
  static bool isKnown(String action) => known.contains(action);
}
