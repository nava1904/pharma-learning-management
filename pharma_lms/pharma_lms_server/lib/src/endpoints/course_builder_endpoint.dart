import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

/// Converts a Map<String, dynamic> to Map<String, String> for Serverpod wire serialization.
Map<String, String> _stringifyMap(Map<String, dynamic> m) =>
    m.map((k, v) => MapEntry(k, v is Map || v is List ? jsonEncode(v) : (v?.toString() ?? '')));

/// Course builder endpoint for SME/trainers (TC-07: restricted editing).
class CourseBuilderEndpoint extends Endpoint {
  Future<Module> createModule(
    Session session, {
    required int courseVersionId,
    required String title,
    int orderIndex = 0,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    await _ensureVersionEditable(session, courseVersionId);
    return await Module.db.insertRow(
      session,
      Module(
        courseVersionId: courseVersionId,
        title: title,
        orderIndex: orderIndex,
      ),
    );
  }

  Future<Module> updateModule(
    Session session, {
    required int moduleId,
    String? title,
    int? orderIndex,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final module = await Module.db.findById(session, moduleId);
    if (module == null) throw Exception('Module not found');
    await _ensureVersionEditable(session, module.courseVersionId);
    final updated = module.copyWith(
      title: title ?? module.title,
      orderIndex: orderIndex ?? module.orderIndex,
    );
    return await Module.db.updateRow(session, updated);
  }

  Future<Lesson> createLesson(
    Session session, {
    required int moduleId,
    required String title,
    required int materialId,
    int orderIndex = 0,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final module = await Module.db.findById(session, moduleId);
    if (module == null) throw Exception('Module not found');
    await _ensureVersionEditable(session, module.courseVersionId);
    final created = await Lesson.db.insertRow(
      session,
      Lesson(
        moduleId: moduleId,
        title: title,
        materialId: materialId,
        orderIndex: orderIndex,
        durationMinutes: durationMinutes,
        lessonType: lessonType,
        minEngagementMinutes: minEngagementMinutes,
        prerequisiteMode: prerequisiteMode,
      ),
    );
    await AuditService.log(
      session,
      entityType: 'lesson',
      entityId: created.id.toString(),
      action: 'LessonCreated',
      newValueJson: jsonEncode(_lessonAuditMap(
        courseVersionId: module.courseVersionId,
        moduleId: moduleId,
        lesson: created,
      )),
    );
    return created;
  }

  Future<Lesson> updateLesson(
    Session session, {
    required int lessonId,
    String? title,
    int? materialId,
    int? orderIndex,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final lesson = await Lesson.db.findById(session, lessonId);
    if (lesson == null) throw Exception('Lesson not found');
    final module = await Module.db.findById(session, lesson.moduleId);
    if (module == null) throw Exception('Module not found');
    await _ensureVersionEditable(session, module.courseVersionId);
    final updated = lesson.copyWith(
      title: title ?? lesson.title,
      materialId: materialId ?? lesson.materialId,
      orderIndex: orderIndex ?? lesson.orderIndex,
      durationMinutes: durationMinutes ?? lesson.durationMinutes,
      lessonType: lessonType ?? lesson.lessonType,
      minEngagementMinutes: minEngagementMinutes ?? lesson.minEngagementMinutes,
      prerequisiteMode: prerequisiteMode ?? lesson.prerequisiteMode,
    );
    final oldJson =
        jsonEncode(_lessonAuditMap(courseVersionId: module.courseVersionId, moduleId: lesson.moduleId, lesson: lesson));
    final newJson =
        jsonEncode(_lessonAuditMap(courseVersionId: module.courseVersionId, moduleId: updated.moduleId, lesson: updated));
    final result = await Lesson.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'lesson',
      entityId: lessonId.toString(),
      action: 'LessonUpdated',
      oldValueJson: oldJson,
      newValueJson: newJson,
    );
    return result;
  }

  /// Create new course version. TC-07: if course has approved version, only allow draft.
  /// When superseding (hasApproved), changeSummary is required (TRN-05).
  Future<CourseVersion> createCourseVersion(
    Session session, {
    required int courseId,
    required String version,
    String status = 'draft',
    String? changeSummary,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final versions = await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
    final hasApproved = versions.any((v) => v.status == 'effective');
    if (hasApproved && status != 'draft') {
      throw Exception('Course has approved version; new version must be draft');
    }
    if (hasApproved && (changeSummary == null || changeSummary.trim().isEmpty)) {
      throw Exception(
        'Change summary is required when creating a new version that supersedes an effective version',
      );
    }
    return await CourseVersion.db.insertRow(
      session,
      CourseVersion(
        courseId: courseId,
        version: version,
        status: status,
        changeSummary: changeSummary,
      ),
    );
  }

  /// TRN-WF-05: Create a new course version from an existing version.
  /// This clones all modules and lessons, increments version, and sets supersededByVersionId.
  /// changeSummary is MANDATORY - describes what changed and why.
  /// Returns the new CourseVersion with all content copied.
  Future<Map<String, String>> createNewVersionFromExisting(
    Session session, {
    required int existingVersionId,
    required String changeSummary,
    bool isMajorVersion = false,
    int? createdById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');

    // Validate change summary is provided
    if (changeSummary.trim().isEmpty) {
      throw Exception('Change summary is required (TRN-WF-05 compliance)');
    }

    // Step 1: Get the existing version
    final existingVersion = await CourseVersion.db.findById(session, existingVersionId);
    if (existingVersion == null) {
      throw Exception('Course version not found');
    }

    // Step 2: Get the course
    final course = await Course.db.findById(session, existingVersion.courseId);
    if (course == null) {
      throw Exception('Course not found');
    }

    // Step 3: Calculate new version number
    final currentVersion = existingVersion.version;
    final newVersion = _incrementVersion(currentVersion, isMajor: isMajorVersion);

    // Step 4: Create new CourseVersion (status=draft)
    final newCourseVersion = await CourseVersion.db.insertRow(
      session,
      CourseVersion(
        courseId: existingVersion.courseId,
        version: newVersion,
        status: 'draft',
        changeSummary: changeSummary,
      ),
    );

    // Step 5: Update old version with supersededByVersionId
    final updatedOldVersion = existingVersion.copyWith(
      supersededByVersionId: newCourseVersion.id,
    );
    await CourseVersion.db.updateRow(session, updatedOldVersion);

    // Step 6: Copy all modules from old version to new version
    final oldModules = await Module.db.find(
      session,
      where: (t) => t.courseVersionId.equals(existingVersionId),
      orderBy: (t) => t.orderIndex,
    );

    final moduleIdMapping = <int, int>{}; // old module id -> new module id

    for (final oldModule in oldModules) {
      final newModule = await Module.db.insertRow(
        session,
        Module(
          courseVersionId: newCourseVersion.id!,
          title: oldModule.title,
          orderIndex: oldModule.orderIndex,
        ),
      );
      if (oldModule.id != null && newModule.id != null) {
        moduleIdMapping[oldModule.id!] = newModule.id!;
      }

      // Step 7: Copy all lessons for this module
      final oldLessons = await Lesson.db.find(
        session,
        where: (t) => t.moduleId.equals(oldModule.id!),
        orderBy: (t) => t.orderIndex,
      );

      for (final oldLesson in oldLessons) {
        await Lesson.db.insertRow(
          session,
          Lesson(
            moduleId: newModule.id!,
            title: oldLesson.title,
            materialId: oldLesson.materialId, // Keep same material reference
            orderIndex: oldLesson.orderIndex,
            durationMinutes: oldLesson.durationMinutes,
          ),
        );
      }
    }

    // Step 8: Copy assessment if exists
    final oldAssessment = await Assessment.db.findFirstRow(
      session,
      where: (t) => t.courseVersionId.equals(existingVersionId),
    );

    if (oldAssessment != null) {
      await Assessment.db.insertRow(
        session,
        Assessment(
          courseVersionId: newCourseVersion.id!,
          questionBankId: oldAssessment.questionBankId,
          passingScore: oldAssessment.passingScore,
          timeLimitMinutes: oldAssessment.timeLimitMinutes,
          maxAttempts: oldAssessment.maxAttempts,
          questionsToDisplay: oldAssessment.questionsToDisplay,
          randomize: oldAssessment.randomize,
        ),
      );
    }

    // Step 9: Audit trail - NewCourseVersionCreated
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: newCourseVersion.id.toString(),
      action: 'NewCourseVersionCreated',
      oldValueJson: '{"oldVersionId":$existingVersionId,"oldVersion":"$currentVersion"}',
      newValueJson:
          '{"newVersionId":${newCourseVersion.id},"newVersion":"$newVersion","changeSummary":"$changeSummary","isMajor":$isMajorVersion}',
      userId: createdById,
    );

    return _stringifyMap({
      'courseVersion': newCourseVersion.toJson(),
      'oldVersionId': existingVersionId,
      'oldVersion': currentVersion,
      'newVersion': newVersion,
      'modulesCopied': oldModules.length,
      'changeSummary': changeSummary,
    });
  }

  /// Helper to increment version string.
  /// Minor: 1.0 -> 1.1, 1.5 -> 1.6
  /// Major: 1.0 -> 2.0, 1.5 -> 2.0
  String _incrementVersion(String version, {bool isMajor = false}) {
    final parts = version.split('.');
    if (parts.length != 2) {
      // Fallback for non-standard versions
      return isMajor ? '2.0' : '1.1';
    }
    final major = int.tryParse(parts[0]) ?? 1;
    final minor = int.tryParse(parts[1]) ?? 0;

    if (isMajor) {
      return '${major + 1}.0';
    } else {
      return '$major.${minor + 1}';
    }
  }

  /// Update course version status. TC-07: approved/effective -> no edit.
  /// Lifecycle: draft -> pending_approval (SME) -> effective (QA). Only QA can set effective.
  Future<CourseVersion> updateCourseVersionStatus(
    Session session, {
    required int courseVersionId,
    required String status,
    int? approverId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final version = await CourseVersion.db.findById(session, courseVersionId);
    if (version == null) throw Exception('Course version not found');
    if (version.status == 'approved' || version.status == 'effective') {
      throw Exception('Cannot edit approved/effective version');
    }
    if (status == 'effective') {
      throw Exception('Only QA can approve and publish (set effective)');
    }
    final updated = version.copyWith(status: status);
    final result = await CourseVersion.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: courseVersionId.toString(),
      action: 'CourseStatusChanged',
      oldValueJson: '{"status":"${version.status}"}',
      newValueJson: '{"status":"$status"}',
      userId: approverId,
    );
    return result;
  }
  
  /// TRN-WF-04: Validate course version for QA submission.
  /// Performs all validation checks required before submitting for QA review.
  /// Returns validation status and detailed results for each rule.
  Future<QaValidationResult> validateForQaSubmission(
    Session session, {
    required int courseVersionId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    
    final version = await CourseVersion.db.findById(
      session,
      courseVersionId,
      include: CourseVersion.include(course: Course.include()),
    );
    if (version == null) throw Exception('Course version not found');
    
    final validationResults = <QaValidationRuleResult>[];
    var allPassed = true;
    
    // Rule 1: Course must be in draft status
    final isDraft = version.status == 'draft';
    validationResults.add(QaValidationRuleResult(
      rule: 'Course Status',
      description: 'Course must be in draft status to submit for QA',
      passed: isDraft,
      detail: isDraft ? 'Status: draft' : 'Current status: ${version.status} (must be draft)',
    ));
    if (!isDraft) allPassed = false;
    
    // Rule 2: At least one module exists
    final modules = await Module.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      orderBy: (t) => t.orderIndex,
    );
    final hasModules = modules.isNotEmpty;
    validationResults.add(QaValidationRuleResult(
      rule: 'Modules Exist',
      description: 'Course must have at least one module',
      passed: hasModules,
      detail: hasModules ? '${modules.length} module(s) found' : 'No modules created',
    ));
    if (!hasModules) allPassed = false;
    
    // Rule 3: All modules must have at least one lesson
    final modulesWithoutLessons = <String>[];
    var totalLessons = 0;
    
    for (final module in modules) {
      final lessons = await Lesson.db.find(
        session,
        where: (t) => t.moduleId.equals(module.id!),
      );
      totalLessons += lessons.length;
      if (lessons.isEmpty) {
        modulesWithoutLessons.add(module.title);
      }
    }
    
    final allModulesHaveLessons = modulesWithoutLessons.isEmpty && modules.isNotEmpty;
    validationResults.add(QaValidationRuleResult(
      rule: 'All Modules Have Lessons',
      description: 'Every module must have at least one lesson',
      passed: allModulesHaveLessons,
      detail: allModulesHaveLessons 
          ? '${modules.length} module(s) with $totalLessons lesson(s) total'
          : 'Missing lessons in: ${modulesWithoutLessons.join(", ")}',
    ));
    if (!allModulesHaveLessons) allPassed = false;
    
    // Rule 4: All lessons must have linked material
    final lessonsWithoutMaterial = <String>[];
    for (final module in modules) {
      final lessons = await Lesson.db.find(
        session,
        where: (t) => t.moduleId.equals(module.id!),
      );
      for (final lesson in lessons) {
        if (lesson.materialId <= 0) {
          lessonsWithoutMaterial.add(lesson.title);
        }
      }
    }
    
    final allLessonsHaveMaterial = lessonsWithoutMaterial.isEmpty && totalLessons > 0;
    validationResults.add(QaValidationRuleResult(
      rule: 'All Lessons Have Material',
      description: 'Every lesson must have linked training material',
      passed: allLessonsHaveMaterial,
      detail: allLessonsHaveMaterial
          ? 'All $totalLessons lesson(s) have material attached'
          : 'Missing material in: ${lessonsWithoutMaterial.take(5).join(", ")}${lessonsWithoutMaterial.length > 5 ? " (+${lessonsWithoutMaterial.length - 5} more)" : ""}',
    ));
    if (!allLessonsHaveMaterial) allPassed = false;
    
    // Rule 5: Assessment must be configured
    final assessments = await Assessment.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    final assessment = assessments.isNotEmpty ? assessments.first : null;
    final hasAssessment = assessment != null;
    validationResults.add(QaValidationRuleResult(
      rule: 'Assessment Configured',
      description: 'Course must have an assessment linked',
      passed: hasAssessment,
      detail: hasAssessment
          ? 'Assessment linked (Pass: ${assessment.passingScore}%)'
          : 'No assessment configured for this course version',
    ));
    if (!hasAssessment) allPassed = false;
    
    // Rule 6: TRN-WF-03 2x Question Pool Rule
    var questionPoolValid = false;
    var questionPoolDetail = 'Assessment not configured';
    
    if (assessment != null) {
      final questions = await Question.db.find(
        session,
        where: (t) => t.questionBankId.equals(assessment.questionBankId),
      );
      final questionCount = questions.length;
      final questionsToDisplay = assessment.questionsToDisplay ?? questionCount;
      final minimumRequired = questionsToDisplay * 2;
      
      questionPoolValid = questionCount >= minimumRequired;
      questionPoolDetail = questionPoolValid
          ? '$questionCount questions in bank (≥$minimumRequired required for $questionsToDisplay displayed)'
          : 'Need ${minimumRequired - questionCount} more questions. Bank has $questionCount, need $minimumRequired for $questionsToDisplay displayed.';
    }
    
    validationResults.add(QaValidationRuleResult(
      rule: '2x Question Pool Rule (TRN-WF-03)',
      description: 'Questions to display must be ≤ Question Bank / 2',
      passed: hasAssessment && questionPoolValid,
      detail: questionPoolDetail,
    ));
    if (hasAssessment && !questionPoolValid) allPassed = false;
    
    return QaValidationResult(
      courseVersionId: courseVersionId,
      courseTitle: version.course?.title ?? 'Unknown',
      version: version.version,
      allPassed: allPassed,
      passedCount: validationResults.where((r) => r.passed).length,
      totalRules: validationResults.length,
      validationResults: validationResults,
    );
  }
  
  /// TRN-WF-04: Submit course for QA review.
  /// Validates all rules first, then changes status to pending_approval if all pass.
  /// Returns the updated CourseVersion or throws if validation fails.
  Future<CourseVersion> submitForQaReview(
    Session session, {
    required int courseVersionId,
    int? submittedById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    
    // Run all validations
    final validation = await validateForQaSubmission(
      session,
      courseVersionId: courseVersionId,
    );
    
    if (!validation.allPassed) {
      final failedRules = validation.validationResults
          .where((r) => !r.passed)
          .map((r) => r.rule)
          .toList();
      throw Exception(
        'TRN-WF-04 validation failed: ${failedRules.join(", ")}',
      );
    }
    
    // Update status to pending_approval
    final version = await CourseVersion.db.findById(session, courseVersionId);
    if (version == null) throw Exception('Course version not found');
    
    final updated = version.copyWith(status: 'pending_approval');
    final result = await CourseVersion.db.updateRow(session, updated);
    
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: courseVersionId.toString(),
      action: 'CourseSubmittedForQA',
      oldValueJson: '{"status":"${version.status}"}',
      newValueJson: '{"status":"pending_approval","submittedById":$submittedById}',
      userId: submittedById,
    );
    
    return result;
  }

  /// Delete a module and cascade delete its lessons. Only for draft course versions.
  Future<bool> deleteModule(
    Session session, {
    required int moduleId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final module = await Module.db.findById(session, moduleId);
    if (module == null) throw Exception('Module not found');
    await _ensureVersionEditable(session, module.courseVersionId);
    
    final lessons = await Lesson.db.find(
      session,
      where: (t) => t.moduleId.equals(moduleId),
    );
    for (final lesson in lessons) {
      await Lesson.db.deleteRow(session, lesson);
    }
    await Module.db.deleteRow(session, module);
    
    await AuditService.log(
      session,
      entityType: 'module',
      entityId: moduleId.toString(),
      action: 'ModuleDeleted',
      oldValueJson: '{"title":"${module.title}","courseVersionId":${module.courseVersionId},"lessonCount":${lessons.length}}',
    );
    return true;
  }

  /// Delete a lesson by ID. Only for draft course versions.
  Future<bool> deleteLesson(
    Session session, {
    required int lessonId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final lesson = await Lesson.db.findById(session, lessonId);
    if (lesson == null) throw Exception('Lesson not found');
    final module = await Module.db.findById(session, lesson.moduleId);
    if (module == null) throw Exception('Module not found');
    await _ensureVersionEditable(session, module.courseVersionId);
    
    await Lesson.db.deleteRow(session, lesson);
    
    await AuditService.log(
      session,
      entityType: 'lesson',
      entityId: lessonId.toString(),
      action: 'LessonDeleted',
      oldValueJson: '{"title":"${lesson.title}","moduleId":${lesson.moduleId}}',
    );
    return true;
  }

  /// Update a lesson's materialId (replaces hardcoded materialId: 1).
  Future<Lesson> updateLessonMaterial(
    Session session, {
    required int lessonId,
    required int materialId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final lesson = await Lesson.db.findById(session, lessonId);
    if (lesson == null) throw Exception('Lesson not found');
    final module = await Module.db.findById(session, lesson.moduleId);
    if (module == null) throw Exception('Module not found');
    await _ensureVersionEditable(session, module.courseVersionId);
    
    final updated = lesson.copyWith(materialId: materialId);
    return await Lesson.db.updateRow(session, updated);
  }

  /// Bulk save module/lesson ordering and metadata changes.
  Future<bool> saveDraft(
    Session session, {
    required int courseVersionId,
    required List<Map<String, dynamic>> modules,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    await _ensureVersionEditable(session, courseVersionId);
    
    for (final moduleData in modules) {
      final moduleId = moduleData['id'] as int?;
      if (moduleId == null) continue;
      
      final module = await Module.db.findById(session, moduleId);
      if (module == null) continue;
      
      final updatedModule = module.copyWith(
        title: moduleData['title'] as String? ?? module.title,
        orderIndex: moduleData['orderIndex'] as int? ?? module.orderIndex,
      );
      await Module.db.updateRow(session, updatedModule);
      
      final lessonsData = moduleData['lessons'] as List<dynamic>?;
      if (lessonsData != null) {
        for (final lessonData in lessonsData) {
          final ld = lessonData as Map<String, dynamic>;
          final lessonId = ld['id'] as int?;
          if (lessonId == null) continue;
          
          final lesson = await Lesson.db.findById(session, lessonId);
          if (lesson == null) continue;
          
          final updatedLesson = lesson.copyWith(
            title: ld['title'] as String? ?? lesson.title,
            orderIndex: ld['orderIndex'] as int? ?? lesson.orderIndex,
            durationMinutes: ld['durationMinutes'] as int? ?? lesson.durationMinutes,
          );
          await Lesson.db.updateRow(session, updatedLesson);
        }
      }
    }
    
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: courseVersionId.toString(),
      action: 'DraftSaved',
      newValueJson: '{"moduleCount":${modules.length}}',
    );
    return true;
  }

  Future<void> _ensureVersionEditable(Session session, int courseVersionId) async {
    final version = await CourseVersion.db.findById(session, courseVersionId);
    if (version == null) throw Exception('Course version not found');
    if (version.status == 'approved' || version.status == 'effective') {
      throw Exception('Cannot edit approved/effective course version');
    }
  }
}

/// Compact JSON for lesson audit rows (title truncated; no full HTML).
Map<String, dynamic> _lessonAuditMap({
  required int courseVersionId,
  required int moduleId,
  required Lesson lesson,
}) {
  final t = lesson.title;
  return {
    'courseVersionId': courseVersionId,
    'moduleId': moduleId,
    if (lesson.id != null) 'lessonId': lesson.id,
    'title': t.length > 120 ? '${t.substring(0, 120)}…' : t,
    'materialId': lesson.materialId,
    'orderIndex': lesson.orderIndex,
    'durationMinutes': lesson.durationMinutes,
    'minEngagementMinutes': lesson.minEngagementMinutes,
    'lessonType': lesson.lessonType,
    'prerequisiteMode': lesson.prerequisiteMode,
  };
}
