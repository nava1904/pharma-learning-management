import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Seed endpoint for development/demo data.
/// Call runSeed() to populate organizations, sites, departments, users, courses.
class SeedEndpoint extends Endpoint {
  /// Seeds the database with sample data if empty. Idempotent - skips if org exists.
  Future<String> runSeed(Session session) async {
    final existing = await Organization.db.find(session);
    if (existing.isNotEmpty) {
      return 'Database already has data, skipping seed. (${existing.length} orgs)';
    }

    // Organization
    final org = await Organization.db.insertRow(
      session,
      Organization(name: 'PharmaCorp Demo', code: 'PHARMA'),
    );

    // Site
    final site = await Site.db.insertRow(
      session,
      Site(
        organizationId: org.id!,
        name: 'HQ Manufacturing',
        code: 'HQ',
        timezone: 'America/New_York',
      ),
    );

    // Departments
    final deptQa = await Department.db.insertRow(
      session,
      Department(siteId: site.id!, name: 'Quality Assurance', code: 'QA'),
    );
    final deptProd = await Department.db.insertRow(
      session,
      Department(siteId: site.id!, name: 'Production', code: 'PROD'),
    );

    // Job roles
    final jobQa = await JobRole.db.insertRow(
      session,
      JobRole(
        departmentId: deptQa.id!,
        name: 'QA Specialist',
        code: 'QA-SPEC',
      ),
    );
    final jobOp = await JobRole.db.insertRow(
      session,
      JobRole(
        departmentId: deptProd.id!,
        name: 'Production Operator',
        code: 'PROD-OP',
      ),
    );

    // Users
    final user1 = await PharmaUser.db.insertRow(
      session,
      PharmaUser(
        email: 'admin@pharmacorp.demo',
        firstName: 'Admin',
        lastName: 'User',
        departmentId: deptQa.id!,
        jobRoleId: jobQa.id!,
        siteId: site.id!,
        organizationId: org.id!,
      ),
    );
    final user2 = await PharmaUser.db.insertRow(
      session,
      PharmaUser(
        email: 'employee@pharmacorp.demo',
        firstName: 'Jane',
        lastName: 'Employee',
        departmentId: deptProd.id!,
        jobRoleId: jobOp.id!,
        siteId: site.id!,
        organizationId: org.id!,
      ),
    );

    // Course (createdById required in DB - use user1)
    final course = await Course.db.insertRow(
      session,
      Course(
        title: 'GMP Basics - 21 CFR Part 11',
        sopNumber: 'SOP-101',
        description:
            'Introduction to Good Manufacturing Practice and electronic records.',
        status: 'approved',
        createdById: user1.id,
        organizationId: org.id!,
      ),
    );

    // Course version
    final courseVersion = await CourseVersion.db.insertRow(
      session,
      CourseVersion(
        courseId: course.id!,
        version: '1.0',
        status: 'approved',
      ),
    );

    // Material for lessons
    final material1 = await Material.db.insertRow(
      session,
      Material(
        title: 'GMP Introduction',
        materialType: 'pdf',
        storageKey: 'materials/gmp-intro.pdf',
        organizationId: org.id!,
      ),
    );
    final material2 = await Material.db.insertRow(
      session,
      Material(
        title: '21 CFR Part 11 Overview',
        materialType: 'pdf',
        storageKey: 'materials/21cfr-part11.pdf',
        organizationId: org.id!,
      ),
    );

    // Module and lessons
    final module1 = await Module.db.insertRow(
      session,
      Module(
        courseVersionId: courseVersion.id!,
        title: 'Module 1: GMP Basics',
        orderIndex: 0,
      ),
    );
    await Lesson.db.insertRow(
      session,
      Lesson(
        moduleId: module1.id!,
        title: 'Introduction to GMP',
        orderIndex: 0,
        materialId: material1.id!,
        durationMinutes: 5,
      ),
    );
    await Lesson.db.insertRow(
      session,
      Lesson(
        moduleId: module1.id!,
        title: '21 CFR Part 11',
        orderIndex: 1,
        materialId: material2.id!,
        durationMinutes: 10,
      ),
    );

    // Question bank and questions
    final questionBank = await QuestionBank.db.insertRow(
      session,
      QuestionBank(
        name: 'GMP Basics Quiz',
        organizationId: org.id!,
        tagsJson: '["GMP","21CFR"]',
      ),
    );

    await Question.db.insertRow(
      session,
      Question(
        questionBankId: questionBank.id!,
        text: 'What does GMP stand for?',
        questionType: 'multiple_choice',
        optionsJson: '["Good Manufacturing Practice","General Medical Protocol","Global Manufacturing Process"]',
        correctAnswer: '0',
        difficulty: 'easy',
      ),
    );
    await Question.db.insertRow(
      session,
      Question(
        questionBankId: questionBank.id!,
        text: '21 CFR Part 11 applies to electronic records.',
        questionType: 'true_false',
        optionsJson: '["true","false"]',
        correctAnswer: 'true',
        difficulty: 'easy',
      ),
    );

    // Assessment
    await Assessment.db.insertRow(
      session,
      Assessment(
        courseVersionId: courseVersion.id!,
        questionBankId: questionBank.id!,
        passingScore: 80,
        randomize: true,
        timeLimitMinutes: 15,
      ),
    );

    // Training assignment and enrollment for employee (user2)
    if (user2.id != null) {
      final assignment = await TrainingAssignment.db.insertRow(
        session,
        TrainingAssignment(
          userId: user2.id!,
          courseVersionId: courseVersion.id!,
          assignedById: user1.id!,
          assignedAt: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 30)),
          priority: 'medium',
          source: 'manual',
        ),
      );
      await Enrollment.db.insertRow(
        session,
        Enrollment(
          userId: user2.id!,
          courseVersionId: courseVersion.id!,
          assignmentId: assignment.id!,
          status: 'not_started',
        ),
      );
    }

    return 'Seed completed: 1 org, 1 site, 2 depts, 2 job roles, 2 users, 1 course, modules, lessons, assessment, assignment.';
  }
}
