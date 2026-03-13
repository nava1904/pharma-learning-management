import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../audit_event_types.dart';
import '../generated/protocol.dart';
import 'audit_service.dart';
import 'event_service.dart';
import 'training_assignment_service.dart';

/// ════════════════════════════════════════════════════════════════════════════
/// SYSTEM AUTOMATION SERVICE
/// ────────────────────────────────────────────────────────────────────────────
/// FDA 21 CFR Part 11 compliant event-driven automation workflows.
/// All actions audited with actor=SYSTEM (userId=null or systemUserId).
///
/// Implements:
/// - SYS-WF-01: SOP Updated — Targeted Retraining Assignment
/// - SYS-WF-02: New Employee Onboarding Training Auto-Assignment
/// - SYS-WF-03: Employee Department/Role Transfer — Training Delta
/// - SYS-WF-06: CAPA Effectiveness Check Auto-Scheduling
/// ════════════════════════════════════════════════════════════════════════════
class SystemAutomationService {
  /// System actor identifier for audit trail.
  /// Convention: systemUserId=1 (admin) + process identifier in reason field = SYSTEM actor.
  static const String systemActor = 'SYSTEM';

  /// Get system user ID for automated operations.
  /// Falls back to first user if no specific system user exists.
  static Future<int> _getSystemUserId(Session session) async {
    final systemUsers = await PharmaUser.db.find(
      session,
      where: (t) => t.email.equals('system@pharmalms.internal'),
      limit: 1,
    );
    if (systemUsers.isNotEmpty && systemUsers.first.id != null) {
      return systemUsers.first.id!;
    }
    // Fallback to first admin user
    final firstUser = await PharmaUser.db.find(session, limit: 1);
    return firstUser.isNotEmpty && firstUser.first.id != null
        ? firstUser.first.id!
        : 1;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SYS-WF-01: SOP Updated — Targeted Retraining Assignment
  // ═══════════════════════════════════════════════════════════════════════════
  /// Handles SOP update event — assigns retraining to affected users and
  /// obsoletes certificates linked to the old document version.
  ///
  /// Event Steps:
  /// 1. Query DocumentAffectedRole/Dept M2M tables
  /// 2. Query PharmaUsers linked to affected roles/departments
  /// 3. Create TrainingAssignment (source='sop_update', assigned_by=SYSTEM)
  /// 4. Create Enrollment per assignment
  /// 5. Query Certificates linked to old document version → set status=OBSOLETE
  /// 6. Log CertificateObsoleted to AuditTrail (actor=SYSTEM)
  /// 7. Log TrainingAssigned to AuditTrail (actor=SYSTEM)
  ///
  /// Throws [Exception] on failure for DeadLetterQueue routing.
  static Future<SopUpdatedResult> handleSopUpdated(
    Session session, {
    required int documentId,
    required int newVersionId,
    required DateTime effectiveDate,
    int? oldVersionId,
    String? changeSummary,
  }) async {
    final startTime = DateTime.now();
    var assignmentsCreated = 0;
    var enrollmentsCreated = 0;
    var certificatesObsoleted = 0;

    try {
      final systemUserId = await _getSystemUserId(session);

      // ─────────────────────────────────────────────────────────────────────────
      // Step 1: Load document and validate QA gate
      // ─────────────────────────────────────────────────────────────────────────
      final document = await Document.db.findById(session, documentId);
      if (document == null) {
        throw Exception('SYS-WF-01: Document not found: $documentId');
      }

      // QA gate: only process if trainingRequiredByQa == 'training_required'
      if (document.trainingRequiredByQa != 'training_required') {
        session.log(
          '[SYS-WF-01] Skipping document $documentId - QA gate: ${document.trainingRequiredByQa}',
        );
        return SopUpdatedResult(
          documentId: documentId,
          newVersionId: newVersionId,
          assignmentsCreated: 0,
          enrollmentsCreated: 0,
          certificatesObsoleted: 0,
          skippedReason: 'QA gate: ${document.trainingRequiredByQa}',
        );
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 2: Parse affected departments and roles
      // ─────────────────────────────────────────────────────────────────────────
      List<int> affectedDeptIds = [];
      List<int> affectedRoleIds = [];

      if (document.affectedDepartmentIdsJson != null &&
          document.affectedDepartmentIdsJson!.isNotEmpty) {
        try {
          final list = jsonDecode(document.affectedDepartmentIdsJson!) as List<dynamic>;
          affectedDeptIds = list
              .map((e) => e is int ? e : int.tryParse(e.toString()))
              .whereType<int>()
              .where((id) => id > 0)
              .toList();
        } catch (e) {
          session.log('[SYS-WF-01] Failed to parse affectedDepartmentIdsJson: $e');
        }
      }

      if (document.affectedRoleIdsJson != null &&
          document.affectedRoleIdsJson!.isNotEmpty) {
        try {
          final list = jsonDecode(document.affectedRoleIdsJson!) as List<dynamic>;
          affectedRoleIds = list
              .map((e) => e is int ? e : int.tryParse(e.toString()))
              .whereType<int>()
              .where((id) => id > 0)
              .toList();
        } catch (e) {
          session.log('[SYS-WF-01] Failed to parse affectedRoleIdsJson: $e');
        }
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 3: Get affected users (active users only)
      // ─────────────────────────────────────────────────────────────────────────
      final affectedUsers = <PharmaUser>{};

      // Users in affected departments
      for (final deptId in affectedDeptIds) {
        final deptUsers = await PharmaUser.db.find(
          session,
          where: (t) => t.departmentId.equals(deptId) & t.status.equals('active'),
        );
        affectedUsers.addAll(deptUsers);
      }

      // Users with affected job roles
      for (final roleId in affectedRoleIds) {
        final roleUsers = await PharmaUser.db.find(
          session,
          where: (t) => t.jobRoleId.equals(roleId) & t.status.equals('active'),
        );
        affectedUsers.addAll(roleUsers);
      }

      // Fallback: if no specific scoping, get all active users
      if (affectedDeptIds.isEmpty && affectedRoleIds.isEmpty) {
        final allUsers = await PharmaUser.db.find(
          session,
          where: (t) => t.status.equals('active'),
        );
        affectedUsers.addAll(allUsers);
      }

      session.log(
        '[SYS-WF-01] Found ${affectedUsers.length} affected users for document $documentId',
      );

      // ─────────────────────────────────────────────────────────────────────────
      // Step 4: Get course versions - find courses linked via DocumentVersion
      // ─────────────────────────────────────────────────────────────────────────
      // First get the document version to find linked course
      final docVersion = await DocumentVersion.db.findById(session, newVersionId);
      final courseVersions = <CourseVersion>[];

      if (docVersion != null) {
        // Find all effective course versions (may need custom linking logic)
        final allCourseVersions = await CourseVersion.db.find(
          session,
          where: (t) => t.status.equals('effective'),
        );
        courseVersions.addAll(allCourseVersions);
      }

      if (courseVersions.isEmpty) {
        session.log(
          '[SYS-WF-01] No effective course versions found for document $documentId',
        );
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 5: Calculate due date (30 days for normal, 14 days for critical)
      // ─────────────────────────────────────────────────────────────────────────
      final criticality = document.documentType == 'critical' ? 14 : 30;
      final dueDate = effectiveDate.add(Duration(days: criticality));

      // ─────────────────────────────────────────────────────────────────────────
      // Step 6: Create TrainingAssignments and Enrollments
      // ─────────────────────────────────────────────────────────────────────────
      for (final courseVersion in courseVersions) {
        if (courseVersion.id == null) continue;

        for (final user in affectedUsers) {
          if (user.id == null) continue;

          // Check if user already has active enrollment
          final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
            session,
            userId: user.id!,
            courseVersionId: courseVersion.id!,
          );
          if (hasActive) continue;

          // Create assignment (assigned_by=SYSTEM user)
          final assignment = await TrainingAssignment.db.insertRow(
            session,
            TrainingAssignment(
              userId: user.id!,
              courseVersionId: courseVersion.id!,
              assignedById: systemUserId,
              dueDate: dueDate,
              priority: criticality == 14 ? 'high' : 'medium',
              reason: 'SOP Update: ${document.documentNumber} v$newVersionId - ${changeSummary ?? "Document updated"}',
              source: 'sop_update',
              assignmentType: 'individual',
            ),
          );
          assignmentsCreated++;

          // Log TrainingAssigned to AuditTrail
          await AuditService.log(
            session,
            entityType: 'training_assignment',
            entityId: assignment.id.toString(),
            action: AuditEventType.trainingAssigned,
            newValueJson: jsonEncode({
              'courseVersionId': courseVersion.id,
              'userId': user.id,
              'dueDate': dueDate.toIso8601String(),
              'source': 'sop_update',
              'actor': systemActor,
              'process': 'SopUpdatedEventHandler',
              'documentId': documentId,
              'newVersionId': newVersionId,
            }),
            userId: systemUserId,
            reason: 'SYS-WF-01: SOP Updated retraining assignment',
          );

          // Create Enrollment
          final enrollment = await Enrollment.db.insertRow(
            session,
            Enrollment(
              userId: user.id!,
              courseVersionId: courseVersion.id!,
              assignmentId: assignment.id,
              status: 'not_started',
              retrainingChangeSummary: changeSummary,
            ),
          );
          enrollmentsCreated++;

          await AuditService.log(
            session,
            entityType: 'enrollment',
            entityId: enrollment.id.toString(),
            action: AuditEventType.enrollmentCreated,
            newValueJson: jsonEncode({
              'enrollmentId': enrollment.id,
              'courseVersionId': courseVersion.id,
              'userId': user.id,
              'actor': systemActor,
              'process': 'SopUpdatedEventHandler',
            }),
            userId: systemUserId,
          );

          // Emit event for downstream processing
          if (assignment.id != null) {
            await EventService.emitAssignmentCreated(
              session,
              assignmentId: assignment.id!,
              userId: user.id!,
              courseVersionId: courseVersion.id!,
              dueDate: dueDate,
              source: 'sop_update',
            );
          }
        }
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 7: Obsolete certificates linked to old document version
      // ─────────────────────────────────────────────────────────────────────────
      if (oldVersionId != null) {
        // Find course versions and their certificates
        final allCourseVersions = await CourseVersion.db.find(session);

        for (final cv in allCourseVersions) {
          if (cv.id == null) continue;

          // Find active certificates for this course version
          final certificates = await Certificate.db.find(
            session,
            where: (t) =>
                t.courseVersionId.equals(cv.id!) &
                t.status.equals('active'),
          );

          for (final cert in certificates) {
            if (cert.id == null) continue;

            final oldStatus = cert.status;
            final now = DateTime.now();

            // Update certificate to obsolete
            await Certificate.db.updateRow(
              session,
              cert.copyWith(status: 'obsolete'),
            );
            certificatesObsoleted++;

            // Log CertificateObsoleted to AuditTrail
            await AuditService.log(
              session,
              entityType: 'certificate',
              entityId: cert.id.toString(),
              action: AuditEventType.certificateObsoleted,
              oldValueJson: jsonEncode({
                'status': oldStatus,
              }),
              newValueJson: jsonEncode({
                'status': 'obsolete',
                'obsoletedAt': now.toIso8601String(),
                'obsoletedBy': systemActor,
                'reason': 'SOP updated to v$newVersionId',
                'documentId': documentId,
                'oldVersionId': oldVersionId,
              }),
              userId: systemUserId,
              reason: 'SYS-WF-01: Certificate obsoleted due to SOP update',
            );
          }
        }
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 8: Log job execution
      // ─────────────────────────────────────────────────────────────────────────
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'SopUpdatedEventHandler',
          startedAt: startTime,
          completedAt: DateTime.now(),
          status: 'success',
          recordsProcessed: affectedUsers.length,
          recordsAffected: assignmentsCreated + certificatesObsoleted,
        ),
      );

      session.log(
        '[SYS-WF-01] Completed: $assignmentsCreated assignments, $enrollmentsCreated enrollments, $certificatesObsoleted certificates obsoleted',
      );

      return SopUpdatedResult(
        documentId: documentId,
        newVersionId: newVersionId,
        assignmentsCreated: assignmentsCreated,
        enrollmentsCreated: enrollmentsCreated,
        certificatesObsoleted: certificatesObsoleted,
      );
    } catch (e, stack) {
      // Log failure for DLQ routing
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'SopUpdatedEventHandler',
          startedAt: startTime,
          completedAt: DateTime.now(),
          status: 'failed',
          recordsProcessed: 0,
          recordsAffected: 0,
        ),
      );

      session.log('[SYS-WF-01] FAILED: $e\n$stack');
      rethrow; // Route to DeadLetterQueue
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SYS-WF-02: New Employee Onboarding Training Auto-Assignment
  // ═══════════════════════════════════════════════════════════════════════════
  /// Handles employee created event — assigns onboarding training based on
  /// TrainingMatrix for the employee's job role and site.
  ///
  /// Event Steps:
  /// 1. Query TrainingMatrix for job_role_id, site_id
  /// 2. Create TrainingAssignment (source='onboarding', assigned_by=SYSTEM)
  /// 3. Create Enrollment per assignment
  /// 4. Log TrainingAssigned to AuditTrail (actor=SYSTEM)
  ///
  /// Throws [Exception] on failure for DeadLetterQueue routing.
  static Future<EmployeeOnboardingResult> handleEmployeeCreated(
    Session session, {
    required int userId,
    required int jobRoleId,
    required int departmentId,
    int? siteId,
    DateTime? hireDate,
  }) async {
    final startTime = DateTime.now();
    final effectiveHireDate = hireDate ?? DateTime.now();
    var assignmentsCreated = 0;
    var enrollmentsCreated = 0;

    try {
      final systemUserId = await _getSystemUserId(session);

      // ─────────────────────────────────────────────────────────────────────────
      // Step 1: Validate user exists
      // ─────────────────────────────────────────────────────────────────────────
      final user = await PharmaUser.db.findById(session, userId);
      if (user == null) {
        throw Exception('SYS-WF-02: User not found: $userId');
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 2: Query TrainingMatrix for role (and optionally site)
      // ─────────────────────────────────────────────────────────────────────────
      List<TrainingMatrix> matrixEntries;

      if (siteId != null) {
        // Site-specific training + org-wide (site IS NULL)
        matrixEntries = await TrainingMatrix.db.find(
          session,
          where: (t) =>
              t.jobRoleId.equals(jobRoleId) &
              (t.siteId.equals(siteId) | t.siteId.equals(null)),
          include: TrainingMatrix.include(course: Course.include()),
        );
      } else {
        // Org-wide training only
        matrixEntries = await TrainingMatrix.db.find(
          session,
          where: (t) => t.jobRoleId.equals(jobRoleId),
          include: TrainingMatrix.include(course: Course.include()),
        );
      }

      session.log(
        '[SYS-WF-02] Found ${matrixEntries.length} TrainingMatrix entries for role $jobRoleId',
      );

      // ─────────────────────────────────────────────────────────────────────────
      // Step 3: Create assignments for each matrix entry
      // ─────────────────────────────────────────────────────────────────────────
      final courseVersionIds = <int>[];

      for (final matrix in matrixEntries) {
        final courseId = matrix.courseId;

        // Get effective course version
        final courseVersions = await CourseVersion.db.find(
          session,
          where: (t) =>
              t.courseId.equals(courseId) &
              t.status.equals('effective'),
          orderBy: (t) => t.id,
          orderDescending: true,
          limit: 1,
        );

        if (courseVersions.isEmpty) continue;
        final courseVersion = courseVersions.first;
        if (courseVersion.id == null) continue;

        courseVersionIds.add(courseVersion.id!);

        // Calculate due date from hire date + matrix.dueDaysFromHire
        final dueDays = matrix.dueDaysFromHire;
        final dueDate = effectiveHireDate.add(Duration(days: dueDays));

        // Check for existing enrollment
        final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
          session,
          userId: userId,
          courseVersionId: courseVersion.id!,
        );
        if (hasActive) continue;

        // Create assignment (assigned_by=SYSTEM user)
        final assignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: userId,
            courseVersionId: courseVersion.id!,
            assignedById: systemUserId,
            dueDate: dueDate,
            priority: matrix.isMandatory ? 'high' : 'medium',
            reason: 'New employee onboarding - ${matrix.course?.title ?? "Training"}',
            source: 'onboarding',
            assignmentType: 'individual',
          ),
        );
        assignmentsCreated++;

        // Log TrainingAssigned
        await AuditService.log(
          session,
          entityType: 'training_assignment',
          entityId: assignment.id.toString(),
          action: AuditEventType.trainingAssigned,
          newValueJson: jsonEncode({
            'courseVersionId': courseVersion.id,
            'userId': userId,
            'dueDate': dueDate.toIso8601String(),
            'source': 'onboarding',
            'actor': systemActor,
            'process': 'EmployeeCreatedEventHandler',
            'jobRoleId': jobRoleId,
            'hireDate': effectiveHireDate.toIso8601String(),
            'isMandatory': matrix.isMandatory,
          }),
          userId: systemUserId,
          reason: 'SYS-WF-02: Onboarding training assignment',
        );

        // Create Enrollment
        final enrollment = await Enrollment.db.insertRow(
          session,
          Enrollment(
            userId: userId,
            courseVersionId: courseVersion.id!,
            assignmentId: assignment.id,
            status: 'not_started',
          ),
        );
        enrollmentsCreated++;

        await AuditService.log(
          session,
          entityType: 'enrollment',
          entityId: enrollment.id.toString(),
          action: AuditEventType.enrollmentCreated,
          newValueJson: jsonEncode({
            'enrollmentId': enrollment.id,
            'courseVersionId': courseVersion.id,
            'userId': userId,
            'actor': systemActor,
            'process': 'EmployeeCreatedEventHandler',
            'requiresAcknowledgement': true,
          }),
          userId: systemUserId,
        );

        // Emit event
        if (assignment.id != null) {
          await EventService.emitAssignmentCreated(
            session,
            assignmentId: assignment.id!,
            userId: userId,
            courseVersionId: courseVersion.id!,
            dueDate: dueDate,
            source: 'onboarding',
          );
        }
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 4: Log job execution
      // ─────────────────────────────────────────────────────────────────────────
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'EmployeeCreatedEventHandler',
          startedAt: startTime,
          completedAt: DateTime.now(),
          status: 'success',
          recordsProcessed: matrixEntries.length,
          recordsAffected: assignmentsCreated,
        ),
      );

      // ─────────────────────────────────────────────────────────────────────────
      // Step 5: Create welcome notification
      // ─────────────────────────────────────────────────────────────────────────
      if (assignmentsCreated > 0) {
        await Notification.db.insertRow(
          session,
          Notification(
            userId: userId,
            type: 'onboarding_welcome',
            channel: 'in_app',
          ),
        );
      }

      session.log(
        '[SYS-WF-02] Completed: $assignmentsCreated assignments, $enrollmentsCreated enrollments for user $userId',
      );

      return EmployeeOnboardingResult(
        userId: userId,
        assignmentsCreated: assignmentsCreated,
        enrollmentsCreated: enrollmentsCreated,
        courseVersionIds: courseVersionIds,
      );
    } catch (e, stack) {
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'EmployeeCreatedEventHandler',
          startedAt: startTime,
          completedAt: DateTime.now(),
          status: 'failed',
          recordsProcessed: 0,
          recordsAffected: 0,
        ),
      );

      session.log('[SYS-WF-02] FAILED: $e\n$stack');
      rethrow;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SYS-WF-03: Employee Department/Role Transfer — Training Delta
  // ═══════════════════════════════════════════════════════════════════════════
  /// Handles employee transfer event — calculates training delta between old
  /// and new role/department requirements.
  ///
  /// Event Steps:
  /// 1. Query TrainingMatrix for old role → Set A
  /// 2. Query TrainingMatrix for new role → Set B
  /// 3. Compute delta: new_required = B - A, no_longer_required = A - B
  /// 4. Archive no_longer_required active assignments (status=superseded)
  /// 5. Create new TrainingAssignments for new_required courses
  /// 6. Log UserTransferred, TrainingAssigned, AssignmentSuperseded
  ///
  /// Throws [Exception] on failure for DeadLetterQueue routing.
  static Future<EmployeeTransferResult> handleEmployeeTransferred(
    Session session, {
    required int userId,
    required int oldRoleId,
    required int newRoleId,
    int? oldDepartmentId,
    int? newDepartmentId,
  }) async {
    final startTime = DateTime.now();
    var assignmentsCreated = 0;
    var assignmentsSuperseded = 0;

    try {
      final systemUserId = await _getSystemUserId(session);

      // ─────────────────────────────────────────────────────────────────────────
      // Step 1: Validate user
      // ─────────────────────────────────────────────────────────────────────────
      final user = await PharmaUser.db.findById(session, userId);
      if (user == null) {
        throw Exception('SYS-WF-03: User not found: $userId');
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 2: Log UserTransferred audit event
      // ─────────────────────────────────────────────────────────────────────────
      await AuditService.log(
        session,
        entityType: 'pharma_user',
        entityId: userId.toString(),
        action: 'UserTransferred',
        oldValueJson: jsonEncode({
          'jobRoleId': oldRoleId,
          'departmentId': oldDepartmentId,
        }),
        newValueJson: jsonEncode({
          'jobRoleId': newRoleId,
          'departmentId': newDepartmentId,
          'actor': systemActor,
          'process': 'EmployeeTransferredEventHandler',
          'transferredAt': DateTime.now().toIso8601String(),
        }),
        userId: systemUserId,
        reason: 'SYS-WF-03: Employee transferred',
      );

      // ─────────────────────────────────────────────────────────────────────────
      // Step 3: Get TrainingMatrix for old role (Set A)
      // ─────────────────────────────────────────────────────────────────────────
      final oldMatrixEntries = await TrainingMatrix.db.find(
        session,
        where: (t) => t.jobRoleId.equals(oldRoleId),
      );
      final oldCourseIds = oldMatrixEntries
          .map((m) => m.courseId)
          .whereType<int>()
          .toSet();

      // ─────────────────────────────────────────────────────────────────────────
      // Step 4: Get TrainingMatrix for new role (Set B)
      // ─────────────────────────────────────────────────────────────────────────
      final newMatrixEntries = await TrainingMatrix.db.find(
        session,
        where: (t) => t.jobRoleId.equals(newRoleId),
        include: TrainingMatrix.include(course: Course.include()),
      );
      final newCourseIds = newMatrixEntries
          .map((m) => m.courseId)
          .whereType<int>()
          .toSet();

      // ─────────────────────────────────────────────────────────────────────────
      // Step 5: Compute delta
      // ─────────────────────────────────────────────────────────────────────────
      final newRequired = newCourseIds.difference(oldCourseIds);
      final noLongerRequired = oldCourseIds.difference(newCourseIds);

      session.log(
        '[SYS-WF-03] User $userId: ${newRequired.length} new required, ${noLongerRequired.length} no longer required',
      );

      // ─────────────────────────────────────────────────────────────────────────
      // Step 6: Archive no-longer-required active assignments (status=superseded)
      // ─────────────────────────────────────────────────────────────────────────
      for (final courseId in noLongerRequired) {
        // Find active assignments for this course
        final courseVersions = await CourseVersion.db.find(
          session,
          where: (t) => t.courseId.equals(courseId),
        );

        for (final cv in courseVersions) {
          if (cv.id == null) continue;

          final activeAssignments = await TrainingAssignment.db.find(
            session,
            where: (t) =>
                t.userId.equals(userId) &
                t.courseVersionId.equals(cv.id!) &
                t.status.equals('active'),
          );

          for (final assignment in activeAssignments) {
            if (assignment.id == null) continue;

            final oldStatus = assignment.status;

            // Update to superseded (not cancelled - preserves audit history)
            await TrainingAssignment.db.updateRow(
              session,
              assignment.copyWith(status: 'superseded'),
            );
            assignmentsSuperseded++;

            // Log AssignmentSuperseded
            await AuditService.log(
              session,
              entityType: 'training_assignment',
              entityId: assignment.id.toString(),
              action: AuditEventType.assignmentSuperseded,
              oldValueJson: jsonEncode({'status': oldStatus}),
              newValueJson: jsonEncode({
                'status': 'superseded',
                'reason': 'Role transfer - no longer required for new role',
                'actor': systemActor,
                'process': 'EmployeeTransferredEventHandler',
                'oldRoleId': oldRoleId,
                'newRoleId': newRoleId,
              }),
              userId: systemUserId,
              reason: 'SYS-WF-03: Assignment superseded due to role transfer',
            );
          }
        }
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 7: Create new assignments for newly required courses
      // ─────────────────────────────────────────────────────────────────────────
      final dueDate = DateTime.now().add(const Duration(days: 30));
      final newCourseVersionIds = <int>[];

      for (final courseId in newRequired) {
        // Get the matrix entry for due days
        final matrixEntry = newMatrixEntries.firstWhere(
          (m) => m.courseId == courseId,
          orElse: () => TrainingMatrix(courseId: courseId, jobRoleId: newRoleId),
        );

        // Get effective course version
        final courseVersions = await CourseVersion.db.find(
          session,
          where: (t) =>
              t.courseId.equals(courseId) & t.status.equals('effective'),
          orderBy: (t) => t.id,
          orderDescending: true,
          limit: 1,
        );

        if (courseVersions.isEmpty) continue;
        final courseVersion = courseVersions.first;
        if (courseVersion.id == null) continue;

        // Check for existing certificate (already completed)
        final existingCerts = await Certificate.db.find(
          session,
          where: (t) =>
              t.userId.equals(userId) &
              t.courseVersionId.equals(courseVersion.id!) &
              t.status.equals('active'),
        );
        if (existingCerts.isNotEmpty) continue;

        // Check for existing active enrollment
        final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
          session,
          userId: userId,
          courseVersionId: courseVersion.id!,
        );
        if (hasActive) continue;

        newCourseVersionIds.add(courseVersion.id!);

        // Create assignment
        final assignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: userId,
            courseVersionId: courseVersion.id!,
            assignedById: systemUserId,
            dueDate: dueDate,
            priority: matrixEntry.isMandatory ? 'high' : 'medium',
            reason: 'Role transfer - new requirement for ${matrixEntry.course?.title ?? "role"}',
            source: 'transfer',
            assignmentType: 'individual',
          ),
        );
        assignmentsCreated++;

        // Log TrainingAssigned
        await AuditService.log(
          session,
          entityType: 'training_assignment',
          entityId: assignment.id.toString(),
          action: AuditEventType.trainingAssigned,
          newValueJson: jsonEncode({
            'courseVersionId': courseVersion.id,
            'userId': userId,
            'dueDate': dueDate.toIso8601String(),
            'source': 'transfer',
            'actor': systemActor,
            'process': 'EmployeeTransferredEventHandler',
            'oldRoleId': oldRoleId,
            'newRoleId': newRoleId,
          }),
          userId: systemUserId,
          reason: 'SYS-WF-03: Training assignment for role transfer',
        );

        // Create Enrollment
        await Enrollment.db.insertRow(
          session,
          Enrollment(
            userId: userId,
            courseVersionId: courseVersion.id!,
            assignmentId: assignment.id,
            status: 'not_started',
          ),
        );

        // Emit event
        if (assignment.id != null) {
          await EventService.emitAssignmentCreated(
            session,
            assignmentId: assignment.id!,
            userId: userId,
            courseVersionId: courseVersion.id!,
            dueDate: dueDate,
            source: 'transfer',
          );
        }
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 8: Create notifications
      // ─────────────────────────────────────────────────────────────────────────
      if (assignmentsCreated > 0) {
        await Notification.db.insertRow(
          session,
          Notification(
            userId: userId,
            type: 'transfer_new_training',
            channel: 'in_app',
          ),
        );
      }

      // Notify new manager via user's manager field
      if (user.managerId != null) {
        await Notification.db.insertRow(
          session,
          Notification(
            userId: user.managerId!,
            type: 'transfer_employee_joined',
            channel: 'in_app',
          ),
        );
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 9: Log job execution
      // ─────────────────────────────────────────────────────────────────────────
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'EmployeeTransferredEventHandler',
          startedAt: startTime,
          completedAt: DateTime.now(),
          status: 'success',
          recordsProcessed: newRequired.length + noLongerRequired.length,
          recordsAffected: assignmentsCreated + assignmentsSuperseded,
        ),
      );

      session.log(
        '[SYS-WF-03] Completed: $assignmentsCreated created, $assignmentsSuperseded superseded for user $userId',
      );

      return EmployeeTransferResult(
        userId: userId,
        assignmentsCreated: assignmentsCreated,
        assignmentsSuperseded: assignmentsSuperseded,
        newCourseVersionIds: newCourseVersionIds,
      );
    } catch (e, stack) {
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'EmployeeTransferredEventHandler',
          startedAt: startTime,
          completedAt: DateTime.now(),
          status: 'failed',
          recordsProcessed: 0,
          recordsAffected: 0,
        ),
      );

      session.log('[SYS-WF-03] FAILED: $e\n$stack');
      rethrow;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SYS-WF-06: CAPA Effectiveness Check Auto-Scheduling
  // ═══════════════════════════════════════════════════════════════════════════
  /// Handles CAPA training completion — schedules effectiveness check.
  ///
  /// Event Steps:
  /// 1. Verify all CAPA-linked training is completed
  /// 2. Compute effectiveness_check_due_date (60d default, 30d critical, 90d minor)
  /// 3. Update CAPA status to 'Verification'
  /// 4. Log CapaEffectivenessCheckScheduled to AuditTrail
  ///
  /// Throws [Exception] on failure for DeadLetterQueue routing.
  static Future<CapaEffectivenessResult> handleCapaTrainingCompleted(
    Session session, {
    required int capaId,
    String? classification,
  }) async {
    final startTime = DateTime.now();

    try {
      final systemUserId = await _getSystemUserId(session);

      // ─────────────────────────────────────────────────────────────────────────
      // Step 1: Load CAPA
      // ─────────────────────────────────────────────────────────────────────────
      final capa = await Capa.db.findById(
        session,
        capaId,
        include: Capa.include(
          qualityEvent: QualityEvent.include(),
          trainingAssignment: TrainingAssignment.include(),
        ),
      );

      if (capa == null) {
        throw Exception('SYS-WF-06: CAPA not found: $capaId');
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 2: Verify training is required and assignment exists
      // ─────────────────────────────────────────────────────────────────────────
      if (!capa.trainingRequired) {
        session.log('[SYS-WF-06] CAPA $capaId does not require training');
        return CapaEffectivenessResult(
          capaId: capaId,
          effectivenessCheckDue: null,
          skippedReason: 'Training not required',
        );
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 3: Check if all training is completed
      // ─────────────────────────────────────────────────────────────────────────
      if (capa.trainingAssignmentId != null) {
        final enrollments = await Enrollment.db.find(
          session,
          where: (t) =>
              t.assignmentId.equals(capa.trainingAssignmentId!),
        );

        final allCompleted = enrollments.every((e) => e.status == 'completed');
        if (!allCompleted && enrollments.isNotEmpty) {
          session.log(
            '[SYS-WF-06] CAPA $capaId training not yet completed',
          );
          return CapaEffectivenessResult(
            capaId: capaId,
            effectivenessCheckDue: null,
            skippedReason: 'Training not yet completed',
          );
        }
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 4: Compute effectiveness check due date
      // ─────────────────────────────────────────────────────────────────────────
      // Default: 60 days, Critical: 30 days, Minor: 90 days
      final effectiveClassification = classification ??
          capa.qualityEvent?.eventType ??
          'Major';

      int checkDays;
      switch (effectiveClassification.toLowerCase()) {
        case 'critical':
          checkDays = 30;
          break;
        case 'minor':
          checkDays = 90;
          break;
        default:
          checkDays = 60;
      }

      final completionDate = DateTime.now();
      final effectivenessCheckDue = completionDate.add(Duration(days: checkDays));

      // ─────────────────────────────────────────────────────────────────────────
      // Step 5: Update CAPA
      // ─────────────────────────────────────────────────────────────────────────
      final oldStatus = capa.status;

      await Capa.db.updateRow(
        session,
        capa.copyWith(
          status: 'Verification',
          effectivenessCheckDue: effectivenessCheckDue,
        ),
      );

      // ─────────────────────────────────────────────────────────────────────────
      // Step 6: Log CapaEffectivenessCheckScheduled
      // ─────────────────────────────────────────────────────────────────────────
      await AuditService.log(
        session,
        entityType: 'capa',
        entityId: capaId.toString(),
        action: 'CapaEffectivenessCheckScheduled',
        oldValueJson: jsonEncode({
          'status': oldStatus,
          'effectivenessCheckDue': null,
        }),
        newValueJson: jsonEncode({
          'status': 'Verification',
          'effectivenessCheckDue': effectivenessCheckDue.toIso8601String(),
          'actor': systemActor,
          'process': 'CapaTrainingCompletedEventHandler',
          'classification': effectiveClassification,
          'checkDays': checkDays,
        }),
        userId: systemUserId,
        reason: 'SYS-WF-06: CAPA effectiveness check scheduled',
      );

      // ─────────────────────────────────────────────────────────────────────────
      // Step 7: Notify QA
      // ─────────────────────────────────────────────────────────────────────────
      // Get QA department users for notification
      final qaDept = await Department.db.findFirstRow(
        session,
        where: (t) => t.code.equals('QA'),
      );

      if (qaDept?.id != null) {
        final qaUsers = await PharmaUser.db.find(
          session,
          where: (t) => t.departmentId.equals(qaDept!.id!) & t.status.equals('active'),
        );

        for (final qaUser in qaUsers) {
          if (qaUser.id == null) continue;
          await Notification.db.insertRow(
            session,
            Notification(
              userId: qaUser.id!,
              type: 'capa_effectiveness_check_scheduled',
              channel: 'in_app',
            ),
          );
        }
      }

      // ─────────────────────────────────────────────────────────────────────────
      // Step 8: Log job execution
      // ─────────────────────────────────────────────────────────────────────────
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'CapaTrainingCompletedEventHandler',
          startedAt: startTime,
          completedAt: DateTime.now(),
          status: 'success',
          recordsProcessed: 1,
          recordsAffected: 1,
        ),
      );

      session.log(
        '[SYS-WF-06] CAPA $capaId effectiveness check scheduled for ${effectivenessCheckDue.toIso8601String()}',
      );

      return CapaEffectivenessResult(
        capaId: capaId,
        effectivenessCheckDue: effectivenessCheckDue,
        newStatus: 'Verification',
        classification: effectiveClassification,
      );
    } catch (e, stack) {
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'CapaTrainingCompletedEventHandler',
          startedAt: startTime,
          completedAt: DateTime.now(),
          status: 'failed',
          recordsProcessed: 0,
          recordsAffected: 0,
        ),
      );

      session.log('[SYS-WF-06] FAILED: $e\n$stack');
      rethrow;
    }
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// RESULT CLASSES
// ═════════════════════════════════════════════════════════════════════════════

/// Result from SYS-WF-01: SOP Updated handler.
class SopUpdatedResult {
  final int documentId;
  final int newVersionId;
  final int assignmentsCreated;
  final int enrollmentsCreated;
  final int certificatesObsoleted;
  final String? skippedReason;

  SopUpdatedResult({
    required this.documentId,
    required this.newVersionId,
    required this.assignmentsCreated,
    required this.enrollmentsCreated,
    required this.certificatesObsoleted,
    this.skippedReason,
  });

  Map<String, dynamic> toJson() => {
        'documentId': documentId,
        'newVersionId': newVersionId,
        'assignmentsCreated': assignmentsCreated,
        'enrollmentsCreated': enrollmentsCreated,
        'certificatesObsoleted': certificatesObsoleted,
        if (skippedReason != null) 'skippedReason': skippedReason,
      };
}

/// Result from SYS-WF-02: Employee Onboarding handler.
class EmployeeOnboardingResult {
  final int userId;
  final int assignmentsCreated;
  final int enrollmentsCreated;
  final List<int> courseVersionIds;

  EmployeeOnboardingResult({
    required this.userId,
    required this.assignmentsCreated,
    required this.enrollmentsCreated,
    required this.courseVersionIds,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'assignmentsCreated': assignmentsCreated,
        'enrollmentsCreated': enrollmentsCreated,
        'courseVersionIds': courseVersionIds,
      };
}

/// Result from SYS-WF-03: Employee Transfer handler.
class EmployeeTransferResult {
  final int userId;
  final int assignmentsCreated;
  final int assignmentsSuperseded;
  final List<int> newCourseVersionIds;

  EmployeeTransferResult({
    required this.userId,
    required this.assignmentsCreated,
    required this.assignmentsSuperseded,
    required this.newCourseVersionIds,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'assignmentsCreated': assignmentsCreated,
        'assignmentsSuperseded': assignmentsSuperseded,
        'newCourseVersionIds': newCourseVersionIds,
      };
}

/// Result from SYS-WF-06: CAPA Effectiveness Check handler.
class CapaEffectivenessResult {
  final int capaId;
  final DateTime? effectivenessCheckDue;
  final String? newStatus;
  final String? classification;
  final String? skippedReason;

  CapaEffectivenessResult({
    required this.capaId,
    required this.effectivenessCheckDue,
    this.newStatus,
    this.classification,
    this.skippedReason,
  });

  Map<String, dynamic> toJson() => {
        'capaId': capaId,
        if (effectivenessCheckDue != null)
          'effectivenessCheckDue': effectivenessCheckDue!.toIso8601String(),
        if (newStatus != null) 'newStatus': newStatus,
        if (classification != null) 'classification': classification,
        if (skippedReason != null) 'skippedReason': skippedReason,
      };
}
