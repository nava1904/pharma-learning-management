import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Course & Curriculum domain endpoint.
class CourseEndpoint extends Endpoint {
  Future<List<Course>> listCourses(
    Session session, {
    int? organizationId,
    String? status,
  }) async {
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
    return await Course.db.findById(session, id);
  }

  Future<List<CourseVersion>> getCourseVersions(
    Session session,
    int courseId,
  ) async {
    return await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
  }

  Future<CourseVersion?> getCourseVersion(
    Session session,
    int courseVersionId,
  ) async {
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
    final course = Course(
      title: title,
      organizationId: organizationId,
      sopNumber: sopNumber,
      description: description,
      createdById: createdById,
    );
    return await Course.db.insertRow(session, course);
  }

  Future<List<Module>> getModulesForCourseVersion(
    Session session,
    int courseVersionId,
  ) async {
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
    return await Lesson.db.findById(
      session,
      lessonId,
      include: Lesson.include(material: Material.include()),
    );
  }
}
