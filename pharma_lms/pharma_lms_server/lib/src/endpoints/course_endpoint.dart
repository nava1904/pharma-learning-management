import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

/// Course & Curriculum domain endpoint.
class CourseEndpoint extends Endpoint {
  Future<List<Course>> listCourses(
    Session session, {
    int? organizationId,
    String? status,
    String? search,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return [];

    List<Course> results;
    if (organizationId != null) {
      results = await Course.db.find(
        session,
        where: (t) => t.organizationId.equals(organizationId),
      );
    } else {
      results = await Course.db.find(session);
    }

    if (status != null) {
      results = results.where((c) => c.status == status).toList();
    }

    if (search != null && search.trim().isNotEmpty) {
      final q = search.trim().toLowerCase();
      results = results.where((c) =>
        c.title.toLowerCase().contains(q) ||
        (c.sopNumber?.toLowerCase().contains(q) ?? false) ||
        (c.description?.toLowerCase().contains(q) ?? false)
      ).toList();
    }

    return results;
  }

  /// Courses the signed-in user created in their org that are assignable: published
  /// (approved / published / effective / [publishedAt]) or have an approved/effective version.
  ///
  /// [search] optional DB filter (ILIKE on title, SOP, description).
  Future<List<Course>> listTrainerPublishedCoursesForAssignment(
    Session session, {
    String? search,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'assign')) {
      return [];
    }

    final trainerId = me!.id!;
    final orgId = me.organizationId;

    final trimmed = search?.trim();
    final mine = await Course.db.find(
      session,
      where: (t) {
        var w =
            t.organizationId.equals(orgId) & t.createdById.equals(trainerId);
        if (trimmed != null && trimmed.isNotEmpty) {
          final p = '%${_escapeIlikePattern(trimmed)}%';
          w = w &
              (t.title.ilike(p) |
                  t.sopNumber.ilike(p) |
                  t.description.ilike(p));
        }
        return w;
      },
    );
    if (mine.isEmpty) return [];

    bool courseLooksPublished(Course c) {
      const live = {'approved', 'published', 'effective'};
      if (c.publishedAt != null) return true;
      return live.contains(c.status);
    }

    final courseIds = mine.map((c) => c.id!).toSet();
    final versions = await CourseVersion.db.find(
      session,
      where: (t) =>
          t.courseId.inSet(courseIds) & t.status.inSet({'effective', 'approved'}),
    );
    final courseIdsWithLiveVersion = versions.map((v) => v.courseId).toSet();

    final out = mine
        .where(
          (c) =>
              courseLooksPublished(c) ||
              courseIdsWithLiveVersion.contains(c.id),
        )
        .toList();
    out.sort(
      (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
    );
    return out;
  }

  static String _escapeIlikePattern(String s) {
    return s
        .replaceAll(r'\', r'\\')
        .replaceAll('%', r'\%')
        .replaceAll('_', r'\_');
  }

  Future<Course?> getCourse(Session session, int id) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return null;
    return await Course.db.findById(session, id);
  }

  Future<List<CourseVersion>> getCourseVersions(
    Session session,
    int courseId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return [];
    return await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
  }

  Future<CourseVersion?> getCourseVersion(
    Session session,
    int courseVersionId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return null;
    return await CourseVersion.db.findById(
      session,
      courseVersionId,
      include: CourseVersion.include(course: Course.include()),
    );
  }

  Future<Course> createCourse(
    Session session, {
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final course = Course(
      title: title,
      organizationId: organizationId,
      sopNumber: sopNumber,
      description: description,
      createdById: createdById,
    );
    final result = await Course.db.insertRow(session, course);
    await AuditService.log(
      session,
      entityType: 'course',
      entityId: result.id.toString(),
      action: 'CourseCreated',
      newValueJson: '{"title":"$title","organizationId":$organizationId}',
      userId: createdById,
    );
    return result;
  }

  /// TRN-WF-01: Create Course with initial CourseVersion v1.0 atomically.
  /// This is the correct workflow entry point for trainers creating new courses.
  /// Returns a map with 'course' and 'courseVersion' keys.
  Future<Map<String, String>> createCourseWithVersion(
    Session session, {
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
    String? previewVideoUrl,
    String? imageUrl,
    String? tags,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');

    final course = Course(
      title: title,
      organizationId: organizationId,
      sopNumber: sopNumber,
      description: description,
      createdById: createdById,
      status: 'draft',
      previewVideoUrl: previewVideoUrl,
      imageUrl: imageUrl,
      tags: tags,
    );
    final createdCourse = await Course.db.insertRow(session, course);

    // Step 2: Create CourseVersion record (version='1.0', status=draft)
    final courseVersion = CourseVersion(
      courseId: createdCourse.id!,
      version: '1.0',
      status: 'draft',
    );
    final createdVersion = await CourseVersion.db.insertRow(session, courseVersion);

    // Step 3: Audit trail - CourseCreated
    await AuditService.log(
      session,
      entityType: 'course',
      entityId: createdCourse.id.toString(),
      action: 'CourseCreated',
      newValueJson:
          '{"title":"$title","organizationId":$organizationId,"sopNumber":"$sopNumber"}',
      userId: createdById,
    );

    // Step 4: Audit trail - CourseVersionCreated
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: createdVersion.id.toString(),
      action: 'CourseVersionCreated',
      newValueJson: '{"courseId":${createdCourse.id},"version":"1.0","status":"draft"}',
      userId: createdById,
    );

    return {
      'course': jsonEncode(createdCourse.toJson()),
      'courseVersion': jsonEncode(createdVersion.toJson()),
    };
  }

  Future<List<Module>> getModulesForCourseVersion(
    Session session,
    int courseVersionId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return [];
    return await Module.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      orderBy: (t) => t.orderIndex,
    );
  }

  Future<List<Lesson>> getLessonsForModule(
    Session session,
    int moduleId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return [];
    return await Lesson.db.find(
      session,
      where: (t) => t.moduleId.equals(moduleId),
      orderBy: (t) => t.orderIndex,
    );
  }

  Future<Lesson?> getLessonWithMaterial(
    Session session,
    int lessonId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return null;
    return await Lesson.db.findById(
      session,
      lessonId,
      include: Lesson.include(material: Material.include()),
    );
  }

  /// Search courses by title, description, or SOP number.
  Future<List<Course>> searchCourses(
    Session session, {
    required String query,
    int? organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return [];
    
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return [];
    
    var courses = await Course.db.find(session);
    if (organizationId != null) {
      courses = courses.where((c) => c.organizationId == organizationId).toList();
    }
    
    return courses.where((c) {
      final title = c.title.toLowerCase();
      final desc = (c.description ?? '').toLowerCase();
      final sop = (c.sopNumber ?? '').toLowerCase();
      return title.contains(trimmed) || desc.contains(trimmed) || sop.contains(trimmed);
    }).toList();
  }

  /// Update course metadata (title, description, sopNumber, category, etc.).
  Future<Course> updateCourse(
    Session session, {
    required int courseId,
    String? title,
    String? description,
    String? sopNumber,
    String? previewVideoUrl,
    String? imageUrl,
    String? tags,
    String? category,
    bool? disableSelfEnrollment,
    bool? featured,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final course = await Course.db.findById(session, courseId);
    if (course == null) throw Exception('Course not found');
    
    final updated = course.copyWith(
      title: title ?? course.title,
      description: description ?? course.description,
      sopNumber: sopNumber ?? course.sopNumber,
      previewVideoUrl: previewVideoUrl ?? course.previewVideoUrl,
      imageUrl: imageUrl ?? course.imageUrl,
      tags: tags ?? course.tags,
      category: category ?? course.category,
      disableSelfEnrollment: disableSelfEnrollment ?? course.disableSelfEnrollment,
      featured: featured ?? course.featured,
    );
    
    final result = await Course.db.updateRow(session, updated);
    
    await AuditService.log(
      session,
      entityType: 'course',
      entityId: courseId.toString(),
      action: 'CourseUpdated',
      oldValueJson: '{"title":"${course.title}"}',
      newValueJson: '{"title":"${updated.title}"}',
    );
    
    return result;
  }

  /// Delete a draft course with no enrollments. Cascades related rows so FK constraints do not fail.
  Future<void> deleteCourse(
    Session session, {
    required int courseId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final course = await Course.db.findById(session, courseId);
    if (course == null) throw Exception('Course not found');
    if (course.status != 'draft') {
      throw Exception('Only draft courses can be deleted');
    }

    final versions = await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
    for (final v in versions) {
      final enrollments = await Enrollment.db.find(
        session,
        where: (t) => t.courseVersionId.equals(v.id!),
      );
      if (enrollments.isNotEmpty) {
        throw Exception(
          'Cannot delete course: one or more versions still have enrollments. '
          'Cancel or complete enrollments first.',
        );
      }
    }

    await SmeAssignment.db.deleteWhere(
      session,
      where: (t) => t.courseId.equals(courseId),
    );

    for (final v in versions) {
      final vid = v.id;
      if (vid == null) continue;
      await _deleteCourseVersionCascade(session, vid);
    }

    await CourseCompetency.db.deleteWhere(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
    await CourseSopLink.db.deleteWhere(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
    await CurriculumCourse.db.deleteWhere(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
    await TrainingMatrix.db.deleteWhere(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
    await TrainingWaiver.db.deleteWhere(
      session,
      where: (t) => t.courseId.equals(courseId),
    );

    await Course.db.deleteRow(session, course);

    await AuditService.log(
      session,
      entityType: 'course',
      entityId: courseId.toString(),
      action: 'CourseDeleted',
      oldValueJson: '{"title":"${course.title}"}',
    );
  }

  Future<void> _deleteCourseVersionCascade(Session session, int courseVersionId) async {
    await SmeReviewComment.db.deleteWhere(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );

    final tas = await TrainingAssignment.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    for (final a in tas) {
      await TrainingAssignment.db.deleteRow(session, a);
    }

    final batches = await TrainingBatch.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    for (final b in batches) {
      final bid = b.id!;
      await LiveClass.db.deleteWhere(
        session,
        where: (t) => t.batchId.equals(bid),
      );
      await TrainingBatchParticipant.db.deleteWhere(
        session,
        where: (t) => t.batchId.equals(bid),
      );
      await TrainingBatch.db.deleteRow(session, b);
    }

    final certs = await Certificate.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    for (final c in certs) {
      final cid = c.id;
      if (cid != null) {
        await TrainingExpiration.db.deleteWhere(
          session,
          where: (t) => t.certificateId.equals(cid),
        );
      }
      await Certificate.db.deleteRow(session, c);
    }

    final reviews = await CourseReview.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    for (final r in reviews) {
      final cleared = r.esignatureId != null
          ? r.copyWith(esignatureId: null)
          : r;
      if (r.esignatureId != null) {
        await CourseReview.db.updateRow(
          session,
          cleared,
        );
      }
      await CourseReview.db.deleteRow(session, cleared);
    }

    final assessments = await Assessment.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    for (final asmt in assessments) {
      final aid = asmt.id;
      if (aid == null) continue;
      final attempts = await AssessmentAttempt.db.find(
        session,
        where: (t) => t.assessmentId.equals(aid),
      );
      for (final att in attempts) {
        final attId = att.id;
        if (attId == null) continue;
        await AssessmentResult.db.deleteWhere(
          session,
          where: (t) => t.attemptId.equals(attId),
        );
        await AssessmentAttempt.db.deleteRow(session, att);
      }
      await Assessment.db.deleteRow(session, asmt);
    }

    final modules = await Module.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    for (final m in modules) {
      final mid = m.id!;
      final lessons = await Lesson.db.find(
        session,
        where: (t) => t.moduleId.equals(mid),
      );
      for (final lesson in lessons) {
        final lid = lesson.id!;
        await LessonBlock.db.deleteWhere(
          session,
          where: (t) => t.lessonId.equals(lid),
        );
        final assigns = await Assignment.db.find(
          session,
          where: (t) => t.lessonId.equals(lid),
        );
        for (final asg in assigns) {
          final asgId = asg.id!;
          await AssignmentSubmission.db.deleteWhere(
            session,
            where: (t) => t.assignmentId.equals(asgId),
          );
          await Assignment.db.deleteRow(session, asg);
        }
        await Lesson.db.deleteRow(session, lesson);
      }
      await Module.db.deleteRow(session, m);
    }

    await CourseVersion.db.deleteRow(
      session,
      (await CourseVersion.db.findById(session, courseVersionId))!,
    );
  }
}
