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
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'course', action: 'read')) return [];
    if (organizationId != null) {
      var results = await Course.db.find(
        session,
        where: (t) => t.organizationId.equals(organizationId),
      );
      if (status != null) {
        results = results.where((c) => c.status == status).toList();
      }
      return results;
    }
    var results = await Course.db.find(session);
    if (status != null) {
      results = results.where((c) => c.status == status).toList();
    }
    return results;
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
  Future<Map<String, dynamic>> createCourseWithVersion(
    Session session, {
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');

    // Step 1: Create Course record (status=draft, owner_id=Trainer)
    final course = Course(
      title: title,
      organizationId: organizationId,
      sopNumber: sopNumber,
      description: description,
      createdById: createdById,
      status: 'draft',
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
      'course': createdCourse.toJson(),
      'courseVersion': createdVersion.toJson(),
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

  /// Update course metadata (title, description, sopNumber).
  Future<Course> updateCourse(
    Session session, {
    required int courseId,
    String? title,
    String? description,
    String? sopNumber,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final course = await Course.db.findById(session, courseId);
    if (course == null) throw Exception('Course not found');
    
    final updated = course.copyWith(
      title: title ?? course.title,
      description: description ?? course.description,
      sopNumber: sopNumber ?? course.sopNumber,
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

  /// Delete a draft course with no enrollments.
  Future<bool> deleteCourse(
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
        throw Exception('Cannot delete course: has enrollments');
      }
    }
    
    for (final v in versions) {
      final modules = await Module.db.find(
        session,
        where: (t) => t.courseVersionId.equals(v.id!),
      );
      for (final m in modules) {
        final lessons = await Lesson.db.find(
          session,
          where: (t) => t.moduleId.equals(m.id!),
        );
        for (final l in lessons) {
          await Lesson.db.deleteRow(session, l);
        }
        await Module.db.deleteRow(session, m);
      }
      await CourseVersion.db.deleteRow(session, v);
    }
    await Course.db.deleteRow(session, course);
    
    await AuditService.log(
      session,
      entityType: 'course',
      entityId: courseId.toString(),
      action: 'CourseDeleted',
      oldValueJson: '{"title":"${course.title}"}',
    );
    return true;
  }
}
