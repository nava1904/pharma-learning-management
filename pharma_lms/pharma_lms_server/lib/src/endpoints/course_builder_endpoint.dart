import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Course builder endpoint for SME/trainers (TC-07: restricted editing).
class CourseBuilderEndpoint extends Endpoint {
  Future<Module> createModule(
    Session session, {
    required int courseVersionId,
    required String title,
    int orderIndex = 0,
  }) async {
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
  }) async {
    final module = await Module.db.findById(session, moduleId);
    if (module == null) throw Exception('Module not found');
    await _ensureVersionEditable(session, module.courseVersionId);
    return await Lesson.db.insertRow(
      session,
      Lesson(
        moduleId: moduleId,
        title: title,
        materialId: materialId,
        orderIndex: orderIndex,
        durationMinutes: durationMinutes,
      ),
    );
  }

  Future<Lesson> updateLesson(
    Session session, {
    required int lessonId,
    String? title,
    int? materialId,
    int? orderIndex,
    int? durationMinutes,
  }) async {
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
    );
    return await Lesson.db.updateRow(session, updated);
  }

  /// Create new course version. TC-07: if course has approved version, only allow draft.
  Future<CourseVersion> createCourseVersion(
    Session session, {
    required int courseId,
    required String version,
    String status = 'draft',
  }) async {
    final versions = await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
    );
    final hasApproved = versions.any((v) =>
        v.status == 'approved' || v.status == 'effective');
    if (hasApproved && status != 'draft') {
      throw Exception('Course has approved version; new version must be draft');
    }
    return await CourseVersion.db.insertRow(
      session,
      CourseVersion(
        courseId: courseId,
        version: version,
        status: status,
      ),
    );
  }

  /// Update course version status. TC-07: approved -> no edit.
  Future<CourseVersion> updateCourseVersionStatus(
    Session session, {
    required int courseVersionId,
    required String status,
  }) async {
    final version = await CourseVersion.db.findById(session, courseVersionId);
    if (version == null) throw Exception('Course version not found');
    if (version.status == 'approved' || version.status == 'effective') {
      throw Exception('Cannot edit approved/effective version');
    }
    final updated = version.copyWith(status: status);
    return await CourseVersion.db.updateRow(session, updated);
  }

  Future<void> _ensureVersionEditable(Session session, int courseVersionId) async {
    final version = await CourseVersion.db.findById(session, courseVersionId);
    if (version == null) throw Exception('Course version not found');
    if (version.status == 'approved' || version.status == 'effective') {
      throw Exception('Cannot edit approved/effective course version');
    }
  }
}
