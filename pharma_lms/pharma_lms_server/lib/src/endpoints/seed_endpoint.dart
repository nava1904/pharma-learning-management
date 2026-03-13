import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Seed endpoint for development/demo data.
/// Call runSeed() to populate organizations, sites, departments, users, courses.
/// Call runMvpSeed() for full MVP dataset (32 users, 6 courses, 500+ audit entries).
class SeedEndpoint extends Endpoint {
  /// Seeds the database with sample data if empty. Idempotent - skips if org exists.
  /// Signature meanings are always seeded if empty (for existing DBs).
  Future<String> runSeed(Session session) async {
    // Always ensure RBAC roles exist (for existing DBs)
    var roles = await Role.db.find(session);
    if (roles.isEmpty) {
      await Role.db.insertRow(session, Role(name: 'Admin', code: 'admin'));
      await Role.db.insertRow(
        session,
        Role(name: 'QA Director', code: 'qa_director'),
      );
      await Role.db.insertRow(session, Role(name: 'QA', code: 'qa'));
      await Role.db.insertRow(session, Role(name: 'Employee', code: 'employee'));
      roles = await Role.db.find(session);
    }
    // Always ensure RBAC permissions exist (for existing DBs)
    final existingPerms = await Permission.db.find(session);
    if (existingPerms.isEmpty) {
      Role? adminRole;
      Role? qaDirRole;
      Role? qaRole;
      Role? employeeRole;
      for (final r in roles) {
        if (r.code == 'admin') adminRole = r;
        if (r.code == 'qa_director') qaDirRole = r;
        if (r.code == 'qa') qaRole = r;
        if (r.code == 'employee') employeeRole = r;
      }
      if (adminRole?.id != null) {
        await Permission.db.insertRow(
          session,
          Permission(roleId: adminRole!.id!, resource: '*', action: '*'),
        );
      }
      for (final r in [qaDirRole, qaRole]) {
        if (r?.id == null) continue;
        for (final perm in [
          ['training', 'read'],
          ['training', 'assign'],
          ['audit', 'read'],
          ['compliance', 'read'],
          ['analytics', 'read'],
          ['course', 'read'],
          ['course', 'write'],
          ['assessment', 'read'],
          ['assessment', 'write'],
          ['document', 'read'],
          ['document', 'write'],
          ['quality_event', 'read'],
          ['quality_event', 'write'],
          ['inspection', 'read'],
          ['inspection', 'write'],
          ['organization', 'read'],
          ['material', 'read'],
          ['material', 'write'],
        ]) {
          await Permission.db.insertRow(
            session,
            Permission(roleId: r!.id!, resource: perm[0], action: perm[1]),
          );
        }
      }
      if (employeeRole?.id != null) {
        for (final perm in [
          ['training', 'read'],
          ['course', 'read'],
          ['assessment', 'read'],
          ['organization', 'read'],
          ['material', 'read'],
          ['compliance', 'read'],
          ['analytics', 'read'],
        ]) {
          await Permission.db.insertRow(
            session,
            Permission(roleId: employeeRole!.id!, resource: perm[0], action: perm[1]),
          );
        }
      }
    }
    // Ensure admin user has QA Director role when seeding roles
    final adminUser = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals('admin@pharmacorp.demo'),
    );
    if (adminUser?.id != null) {
      Role? adminRole;
      Role? qaDirRole;
      for (final r in roles) {
        if (r.code == 'admin') adminRole = r;
        if (r.code == 'qa_director') qaDirRole = r;
      }
      final existing = await UserRole.db.find(
        session,
        where: (t) => t.userId.equals(adminUser!.id!),
      );
      if (existing.isEmpty && adminRole != null && adminRole.id != null) {
        await UserRole.db.insertRow(
          session,
          UserRole(userId: adminUser!.id!, roleId: adminRole.id!),
        );
      }
      if (qaDirRole != null &&
          qaDirRole.id != null &&
          !existing.any((ur) => ur.roleId == qaDirRole!.id)) {
        await UserRole.db.insertRow(
          session,
          UserRole(userId: adminUser!.id!, roleId: qaDirRole.id!),
        );
      }
    }

    // Always ensure signature meanings exist (for existing DBs upgrading)
    final existingMeanings = await SignatureMeaning.db.find(session);
    if (existingMeanings.isEmpty) {
      await SignatureMeaning.db.insertRow(
        session,
        SignatureMeaning(
          meaning: 'I have reviewed and approve',
          isActive: true,
          orderIndex: 0,
        ),
      );
      await SignatureMeaning.db.insertRow(
        session,
        SignatureMeaning(
          meaning: 'I have performed and verified',
          isActive: true,
          orderIndex: 1,
        ),
      );
      await SignatureMeaning.db.insertRow(
        session,
        SignatureMeaning(
          meaning: 'I have read, understood, and agree to comply',
          isActive: true,
          orderIndex: 2,
        ),
      );
      await SignatureMeaning.db.insertRow(
        session,
        SignatureMeaning(
          meaning: 'I have read and understood',
          isActive: true,
          orderIndex: 3,
        ),
      );
    }

    // Ensure employee role has compliance and analytics read (for employee dashboard).
    Role? employeeRoleForUpgrade;
    for (final r in roles) {
      if (r.code == 'employee') {
        employeeRoleForUpgrade = r;
        break;
      }
    }
    if (employeeRoleForUpgrade?.id != null) {
      final empPerms = await Permission.db.find(
        session,
        where: (t) => t.roleId.equals(employeeRoleForUpgrade!.id!),
      );
      final hasCompliance = empPerms.any((p) => p.resource == 'compliance' && p.action == 'read');
      final hasAnalytics = empPerms.any((p) => p.resource == 'analytics' && p.action == 'read');
      if (!hasCompliance) {
        await Permission.db.insertRow(
          session,
          Permission(roleId: employeeRoleForUpgrade!.id!, resource: 'compliance', action: 'read'),
        );
      }
      if (!hasAnalytics) {
        await Permission.db.insertRow(
          session,
          Permission(roleId: employeeRoleForUpgrade!.id!, resource: 'analytics', action: 'read'),
        );
      }
    }

    final existing = await Organization.db.find(session);
    if (existing.isNotEmpty) {
      return existingMeanings.isEmpty
          ? 'Signature meanings seeded. Database already has org data, skipping full seed.'
          : 'Database already has data, skipping seed. (${existing.length} orgs)';
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

    // RBAC roles (for UserRole - QA Director, Admin)
    final roleAdmin = await Role.db.insertRow(
      session,
      Role(name: 'Admin', code: 'admin'),
    );
    final roleQaDirector = await Role.db.insertRow(
      session,
      Role(name: 'QA Director', code: 'qa_director'),
    );
    final roleQa = await Role.db.insertRow(
      session,
      Role(name: 'QA', code: 'qa'),
    );
    final roleEmployee = await Role.db.insertRow(
      session,
      Role(name: 'Employee', code: 'employee'),
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
    await UserRole.db.insertRow(
      session,
      UserRole(userId: user1.id!, roleId: roleAdmin.id!),
    );
    await UserRole.db.insertRow(
      session,
      UserRole(userId: user1.id!, roleId: roleQaDirector.id!),
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
    await UserRole.db.insertRow(
      session,
      UserRole(userId: user2.id!, roleId: roleEmployee.id!),
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
        status: 'effective',
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

    return 'Seed completed: 1 org, 1 site, 2 depts, 2 job roles, 2 users, 1 course, modules, lessons, assessment, signature meanings, assignment.';
  }

  /// Seeds the full MVP dataset: 32 users, 6 courses, 18 modules, 54 lessons,
  /// 6 assessments, 120 questions, training matrix, assignments, enrollments,
  /// e-signatures, certificates, quality events, CAPAs, waivers, audit trail, etc.
  /// Idempotent - skips if org "PharmaCorp International Ltd" exists.
  Future<String> runMvpSeed(Session session) async {
    const baseDate = '2026-03-01T00:00:00.000Z';
    DateTime dt(int offsetDays) {
      final d = DateTime.parse(baseDate);
      return d.add(Duration(days: offsetDays));
    }

    final existing = await Organization.db.findFirstRow(
      session,
      where: (t) => t.name.equals('PharmaCorp International Ltd'),
    );
    if (existing != null) {
      return 'MVP seed skipped: PharmaCorp International Ltd already exists.';
    }

    // Phase 2: Core hierarchy
    final org = await Organization.db.insertRow(
      session,
      Organization(name: 'PharmaCorp International Ltd', code: 'PHARMA'),
    );
    final orgId = org.id!;

    final siteEu = await Site.db.insertRow(
      session,
      Site(
        organizationId: orgId,
        name: 'PharmaCorp EU (London)',
        code: 'EU',
        timezone: 'Europe/London',
      ),
    );
    final siteUs = await Site.db.insertRow(
      session,
      Site(
        organizationId: orgId,
        name: 'PharmaCorp US (Boston)',
        code: 'US',
        timezone: 'America/New_York',
      ),
    );
    final siteAp = await Site.db.insertRow(
      session,
      Site(
        organizationId: orgId,
        name: 'PharmaCorp APAC (Singapore)',
        code: 'AP',
        timezone: 'Asia/Singapore',
      ),
    );
    final siteId = siteEu.id!;

    final deptData = [
      ['Manufacturing', 'MFG'],
      ['Quality Control', 'QC'],
      ['Regulatory Affairs', 'RA'],
      ['Human Resources', 'HR'],
      ['Engineering', 'ENG'],
      ['Logistics & Supply Chain', 'LOG'],
      ['Information Technology', 'IT'],
      ['Quality Assurance', 'QA'],
    ];
    final deptIds = <int>[];
    for (final d in deptData) {
      final dept = await Department.db.insertRow(
        session,
        Department(siteId: siteId, name: d[0], code: d[1]),
      );
      deptIds.add(dept.id!);
    }

    final roleData = [
      ['Admin', 'admin'],
      ['QA Director', 'qa_director'],
      ['QA', 'qa'],
      ['Trainer', 'trainer'],
      ['Analytics', 'analytics'],
      ['Employee', 'employee'],
      ['Auditor', 'auditor'],
    ];
    final roleIds = <String, int>{};
    for (final r in roleData) {
      final role = await Role.db.insertRow(
        session,
        Role(name: r[0], code: r[1]),
      );
      roleIds[r[1]] = role.id!;
    }

    final jobRoleData = [
      ['Production Operator', 'PROD-OP', deptIds[0]],
      ['QA Specialist', 'QA-SPEC', deptIds[7]],
      ['QC Analyst', 'QC-ANAL', deptIds[1]],
      ['Regulatory Affairs Manager', 'RA-MGR', deptIds[2]],
      ['Warehouse Operator', 'WH-OP', deptIds[5]],
      ['Equipment Engineer', 'ENG-EQ', deptIds[4]],
      ['IT Engineer', 'IT-ENG', deptIds[6]],
      ['Line Supervisor', 'LINE-SUP', deptIds[0]],
      ['Pharmacist', 'PHARM', deptIds[1]],
      ['Validation Engineer', 'VAL-ENG', deptIds[4]],
      ['Logistics Coordinator', 'LOG-CO', deptIds[5]],
      ['Training Coordinator', 'TRN-CO', deptIds[3]],
    ];
    final jobRoleIds = <int>[];
    for (final j in jobRoleData) {
      final jr = await JobRole.db.insertRow(
        session,
        JobRole(
          departmentId: j[2] as int,
          name: j[0] as String,
          code: j[1] as String,
        ),
      );
      jobRoleIds.add(jr.id!);
    }

    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning:
            'I have completed this training and attest that I have read, understood, and will apply the content to my work.',
        isActive: true,
        orderIndex: 0,
        applicableTo: 'training_completion',
      ),
    );
    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning:
            'I have reviewed this training content and approve it as accurate, complete, and compliant with applicable GMP requirements.',
        isActive: true,
        orderIndex: 1,
        applicableTo: 'course_approval',
      ),
    );
    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning:
            'I certify that this Corrective and Preventive Action (CAPA) has been effectively implemented, verified, and is closed.',
        isActive: true,
        orderIndex: 2,
        applicableTo: 'capa_closure',
      ),
    );
    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning:
            'I acknowledge that I have read and understood the contents of this document and will comply with its requirements.',
        isActive: true,
        orderIndex: 3,
        applicableTo: 'doc_acknowledgement',
      ),
    );
    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning:
            'I approve this training waiver as justified, documented, and compliant with applicable regulatory requirements.',
        isActive: true,
        orderIndex: 4,
        applicableTo: 'waiver_approval',
      ),
    );
    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning:
            'I certify that this inspection package is accurate, complete, and represents the official compliance records for the stated scope.',
        isActive: true,
        orderIndex: 5,
        applicableTo: 'course_approval',
      ),
    );

    // Phase 3: Users
    final userData = [
      ['employee@pharmacorp.demo', 'Jane', 'Employee', 'EMP-DEMO', 'employee', deptIds[0], jobRoleIds[0], 'active', -400],
      ['alice@pharmacorp.demo', 'Alice', 'Chen', 'EMP-001', 'employee', deptIds[0], jobRoleIds[0], 'active', -400],
      ['bob@pharmacorp.demo', 'Bob', 'Martinez', 'EMP-002', 'employee', deptIds[1], jobRoleIds[2], 'active', -380],
      ['carol@pharmacorp.demo', 'Carol', 'Williams', 'EMP-003', 'employee', deptIds[0], jobRoleIds[0], 'active', -7],
      ['dave@pharmacorp.demo', 'Dave', 'Patel', 'EMP-004', 'employee', deptIds[5], jobRoleIds[4], 'active', -300],
      ['emma@pharmacorp.demo', 'Emma', 'Thompson', 'EMP-005', 'employee', deptIds[4], jobRoleIds[5], 'active', -500],
      ['admin@pharmacorp.demo', 'Sarah', 'Johnson', 'ADM-001', 'admin', deptIds[3], jobRoleIds[11], 'active', -600],
      ['qa@pharmacorp.demo', "James", "O'Brien", 'QA-001', 'qa', deptIds[7], jobRoleIds[1], 'active', -550],
      ['qa.director@pharmacorp.demo', 'Maria', 'Santos', 'QA-002', 'qa_director', deptIds[7], jobRoleIds[1], 'active', -700],
      ['sme@pharmacorp.demo', 'Michael', 'Zhang', 'SME-001', 'trainer', deptIds[7], jobRoleIds[1], 'active', -450],
      ['sme2@pharmacorp.demo', 'Rachel', 'Kumar', 'SME-002', 'trainer', deptIds[0], jobRoleIds[9], 'active', -420],
      ['analytics@pharmacorp.demo', 'Thomas', 'Andersen', 'ANA-001', 'analytics', deptIds[2], jobRoleIds[3], 'active', -500],
      ['it@pharmacorp.demo', 'Lisa', 'Park', 'IT-001', 'admin', deptIds[6], jobRoleIds[6], 'active', -480],
      ['locked@pharmacorp.demo', 'Kevin', 'Brown', 'EMP-099', 'employee', deptIds[0], jobRoleIds[0], 'locked', -200],
      ['ex.employee@pharmacorp.demo', 'Former', 'Employee', 'EMP-000', 'employee', deptIds[0], jobRoleIds[0], 'terminated', -800],
    ];
    final userIds = <String, int>{};
    var adminId = 0;
    var qaId = 0;
    var smeId = 0;
    for (final u in userData) {
      final hireDate = dt(u[8] as int);
      final user = await PharmaUser.db.insertRow(
        session,
        PharmaUser(
          email: u[0] as String,
          firstName: u[1] as String,
          lastName: u[2] as String,
          employeeId: u[3] as String,
          departmentId: u[5] as int,
          jobRoleId: u[6] as int,
          siteId: siteId,
          organizationId: orgId,
          status: u[7] as String,
          hireDate: hireDate,
        ),
      );
      userIds[u[0] as String] = user.id!;
      final roleType = u[4] as String;
      final roleId = roleIds[roleType] ?? roleIds['employee']!;
      await UserRole.db.insertRow(
        session,
        UserRole(userId: user.id!, roleId: roleId),
      );
      if (roleType == 'admin') adminId = user.id!;
      if (roleType == 'qa' || roleType == 'qa_director') qaId = user.id!;
      if (roleType == 'trainer') smeId = user.id!;
    }
    for (var i = 0; i < 18; i++) {
      final email = 'employee${(i + 1).toString().padLeft(2, '0')}@pharmacorp.demo';
      final user = await PharmaUser.db.insertRow(
        session,
        PharmaUser(
          email: email,
          firstName: 'Employee',
          lastName: (i + 1).toString().padLeft(2, '0'),
          employeeId: 'EMP-${(200 + i).toString().padLeft(3, '0')}',
          departmentId: deptIds[i % 4],
          jobRoleId: jobRoleIds[i % 4],
          siteId: siteId,
          organizationId: orgId,
          status: 'active',
          hireDate: dt(-(100 + i * 15)),
        ),
      );
      userIds[email] = user.id!;
      await UserRole.db.insertRow(
        session,
        UserRole(userId: user.id!, roleId: roleIds['employee']!),
      );
    }
    adminId = userIds['admin@pharmacorp.demo']!;
    qaId = userIds['qa@pharmacorp.demo']!;
    smeId = userIds['sme@pharmacorp.demo']!;
    final qa2Id = userIds['qa.director@pharmacorp.demo']!;
    final aliceId = userIds['alice@pharmacorp.demo']!;
    final bobId = userIds['bob@pharmacorp.demo']!;
    final carolId = userIds['carol@pharmacorp.demo']!;
    final daveId = userIds['dave@pharmacorp.demo']!;

    // Phase 4: Documents and Courses
    final docData = [
      ['Quality Control Testing Procedures', 'SOP-QC-001', 'SOP'],
      ['Good Manufacturing Practice Handbook', 'SOP-GMP-002', 'SOP'],
      ['Cold Chain & Temperature Management', 'SOP-CC-003', 'SOP'],
      ['Aseptic Technique & Clean Room Entry', 'SOP-AS-004', 'SOP'],
    ];
    final docIds = <int>[];
    for (final d in docData) {
      final doc = await Document.db.insertRow(
        session,
        Document(
          title: d[0],
          documentNumber: d[1],
          documentType: d[2],
          organizationId: orgId,
        ),
      );
      docIds.add(doc.id!);
    }

    final docVersionData = [
      [docIds[0], '1.0', 'obsolete', -180, -14],
      [docIds[0], '2.0', 'effective', -14, null],
      [docIds[1], '1.0', 'effective', -180, null],
      [docIds[2], '1.0', 'obsolete', -200, -90],
      [docIds[2], '2.0', 'effective', -90, null],
      [docIds[3], '1.0', 'effective', -200, null],
    ];
    final docVersionIds = <int>[];
    for (final dv in docVersionData) {
      final dvv = await DocumentVersion.db.insertRow(
        session,
        DocumentVersion(
          documentId: dv[0] as int,
          version: dv[1] as String,
          storageKey: 'documents/${dv[0]}/${dv[1]}/document.pdf',
          effectiveDate: dt(dv[3] as int),
          obsoleteDate: dv[4] != null ? dt(dv[4] as int) : null,
        ),
      );
      docVersionIds.add(dvv.id!);
    }

    final courseData = [
      ['GMP Fundamentals', 'published', 'SOP-GMP-002'],
      ['Cold Chain & Temperature Monitoring', 'published', 'SOP-CC-003'],
      ['Aseptic Technique & Clean Room Procedures', 'published', 'SOP-AS-004'],
      ['Drug Safety Awareness & Pharmacovigilance', 'published', null],
      ['Process Validation Fundamentals', 'draft', null],
      ['Data Integrity & 21 CFR Part 11', 'under_review', null],
    ];
    final courseIds = <int>[];
    for (final c in courseData) {
      final course = await Course.db.insertRow(
        session,
        Course(
          title: c[0] as String,
          sopNumber: c[2],
          description: 'Comprehensive pharma training on ${c[0]}.',
          status: c[1] as String,
          createdById: smeId,
          organizationId: orgId,
        ),
      );
      courseIds.add(course.id!);
    }

    final cvData = [
      [courseIds[0], '1.0', 'superseded', -240, -14, true],
      [courseIds[0], '2.0', 'effective', -14, null, false],
      [courseIds[1], '1.0', 'superseded', -180, -90, true],
      [courseIds[1], '2.0', 'effective', -90, null, false],
      [courseIds[2], '1.0', 'effective', -200, null, false],
      [courseIds[3], '1.0', 'effective', -150, null, false],
      [courseIds[4], '1.0', 'draft', null, null, false],
      [courseIds[5], '1.0', 'under_review', null, null, false],
    ];
    final cvIds = <int>[];
    int? cvGmpV2Id;
    int? cvColdchainV2Id;
    int? cvAsepticV1Id;
    int? cvSafetyV1Id;
    int? cvValidationV1Id;
    int? cvDataintegV1Id;
    for (var i = 0; i < cvData.length; i++) {
      final cv = cvData[i];
      final supersededById = null;
      final cvRow = await CourseVersion.db.insertRow(
        session,
        CourseVersion(
          courseId: cv[0] as int,
          version: cv[1] as String,
          status: cv[2] as String,
          effectiveDate: cv[3] != null ? dt(cv[3] as int) : null,
          obsoleteDate: cv[4] != null ? dt(cv[4] as int) : null,
          supersededByVersionId: supersededById,
          changeSummary: cv[1] == '1.0' ? 'Initial version' : 'Updated per SOP v2.0',
        ),
      );
      cvIds.add(cvRow.id!);
      if (i == 1) cvGmpV2Id = cvRow.id!;
      if (i == 3) cvColdchainV2Id = cvRow.id!;
      if (i == 4) cvAsepticV1Id = cvRow.id!;
      if (i == 5) cvSafetyV1Id = cvRow.id!;
      if (i == 6) cvValidationV1Id = cvRow.id!;
      if (i == 7) cvDataintegV1Id = cvRow.id!;
    }
    cvGmpV2Id ??= cvIds[1];
    cvColdchainV2Id ??= cvIds[3];
    cvAsepticV1Id ??= cvIds[4];
    cvSafetyV1Id ??= cvIds[5];
    cvValidationV1Id ??= cvIds[6];
    cvDataintegV1Id ??= cvIds[7];

    final publishedCvs = [cvGmpV2Id, cvColdchainV2Id, cvAsepticV1Id, cvSafetyV1Id];
    final moduleConfigs = [
      ['Introduction to GMP', 'What is GMP and Why It Matters', 'Regulatory Framework Overview (FDA/EMA)', 'Key GMP Principles and ALCOA+'],
      ['Documentation & Data Integrity', 'Good Documentation Practices', 'Electronic Records Under 21 CFR Part 11', 'Data Integrity Failures — Case Studies'],
      ['Quality Systems & CAPA', 'Deviation Management', 'CAPA Lifecycle', 'Effectiveness Monitoring'],
      ['Cold Chain Fundamentals', 'Temperature Sensitivity of Drug Products', 'Cold Chain Infrastructure', 'Monitoring Equipment'],
      ['Temperature Excursions', 'Identifying an Excursion', 'Risk Assessment Protocol', 'Reporting Requirements'],
      ['Transportation & Storage', 'Qualified Container Systems', 'Storage Room SOPs', 'Chain of Custody Documentation'],
      ['Clean Room Classification', 'ISO Classifications Explained', 'Gowning Requirements per Classification', 'Environmental Monitoring'],
      ['Aseptic Technique', 'Core Aseptic Principles', 'Contamination Control Strategies', 'Aseptic Process Simulation'],
      ['Practical Assessment Module', 'Gowning Practical Checklist', 'Clean Room Entry/Exit Procedure', 'Video: Correct Aseptic Technique Demonstration'],
      ['Pharmacovigilance Basics', 'Drug Safety Reporting Obligations', 'Adverse Event Classification', 'MedWatch and EudraVigilance'],
      ['Signal Detection', 'Spontaneous Reporting Systems', 'Signal Evaluation Methodology', 'Case Studies: Major Drug Withdrawals'],
      ['Internal Reporting Procedures', 'Internal SAE Reporting Flow', 'Time-Critical Submissions', 'Practical Exercise: Report Completion'],
    ];
    final moduleIds = <int>[];
    final lessonIds = <List<int>>[];
    final materialIds = <int>[];
    var modIdx = 0;
    for (final cvId in publishedCvs) {
      final numMods = 3;
      for (var mi = 0; mi < numMods; mi++) {
        final config = moduleConfigs[modIdx++];
        final mod = await Module.db.insertRow(
          session,
          Module(
            courseVersionId: cvId,
            title: config[0],
            orderIndex: mi + 1,
          ),
        );
        moduleIds.add(mod.id!);
        final lessons = <int>[];
        for (var li = 1; li <= 3; li++) {
          final mat = await Material.db.insertRow(
            session,
            Material(
              title: config[li],
              materialType: li % 3 == 0 ? 'video' : 'pdf',
              storageKey: 'materials/lesson-$cvId-${mod.id}-$li/content.pdf',
              organizationId: orgId,
            ),
          );
          materialIds.add(mat.id!);
          final lesson = await Lesson.db.insertRow(
            session,
            Lesson(
              moduleId: mod.id!,
              title: config[li],
              orderIndex: li,
              materialId: mat.id!,
              durationMinutes: 10 + (li * 2),
            ),
          );
          lessons.add(lesson.id!);
        }
        lessonIds.add(lessons);
      }
    }

    // Phase 5: Assessments
    final gmpQuestions = [
      ['What does GMP stand for in pharmaceutical manufacturing?', '["Good Manufacturing Practice","General Manufacturing Procedure","Good Medical Protocol","Guided Manufacturing Process"]', '0'],
      ['Which regulation governs electronic records and signatures in the US?', '["21 CFR Part 210","21 CFR Part 211","21 CFR Part 11","EU GMP Annex 11"]', '2'],
      ['What is ALCOA+ in the context of data integrity?', '["An FDA inspection checklist","Principles for data integrity: Attributable, Legible, Contemporaneous, Original, Accurate","An antivirus standard","A GAMP 5 validation framework"]', '1'],
    ];
    final assessCvs = [
      [cvGmpV2Id, 80, 45],
      [cvColdchainV2Id, 75, 30],
      [cvAsepticV1Id, 85, 60],
      [cvSafetyV1Id, 75, 30],
    ];
    final assessIds = <int>[];
    final questionIdsByAssess = <int, List<int>>{};
    for (final ac in assessCvs) {
      final qb = await QuestionBank.db.insertRow(
        session,
        QuestionBank(
          name: 'Assessment for CV ${ac[0]}',
          organizationId: orgId,
          tagsJson: '["GMP","21CFR"]',
        ),
      );
      final qIds = <int>[];
      for (var q = 0; q < 20; q++) {
        final gq = gmpQuestions[q % gmpQuestions.length];
        final qu = await Question.db.insertRow(
          session,
          Question(
            questionBankId: qb.id!,
            text: gq[0],
            questionType: q % 5 == 4 ? 'true_false' : 'multiple_choice',
            optionsJson: gq[1],
            correctAnswer: gq[2],
            difficulty: ['easy', 'medium', 'hard'][q % 3],
          ),
        );
        qIds.add(qu.id!);
      }
      final assess = await Assessment.db.insertRow(
        session,
        Assessment(
          courseVersionId: ac[0],
          questionBankId: qb.id!,
          passingScore: ac[1],
          randomize: true,
          timeLimitMinutes: ac[2],
        ),
      );
      assessIds.add(assess.id!);
      questionIdsByAssess[assess.id!] = qIds;
    }

    // Phase 6: Training matrix
    final matrixData = [
      [jobRoleIds[0], courseIds[0], true, 7],
      [jobRoleIds[0], courseIds[2], true, 14],
      [jobRoleIds[0], courseIds[1], false, 30],
      [jobRoleIds[7], courseIds[0], true, 7],
      [jobRoleIds[7], courseIds[2], true, 14],
      [jobRoleIds[7], courseIds[3], true, 30],
      [jobRoleIds[1], courseIds[0], true, 7],
      [jobRoleIds[1], courseIds[3], true, 14],
      [jobRoleIds[1], courseIds[5], true, 14],
      [jobRoleIds[2], courseIds[0], true, 7],
      [jobRoleIds[2], courseIds[3], true, 14],
      [jobRoleIds[2], courseIds[1], true, 30],
      [jobRoleIds[4], courseIds[0], true, 14],
      [jobRoleIds[4], courseIds[1], true, 7],
      [jobRoleIds[5], courseIds[0], true, 14],
      [jobRoleIds[5], courseIds[4], true, 30],
      [jobRoleIds[9], courseIds[0], true, 7],
      [jobRoleIds[9], courseIds[4], true, 14],
      [jobRoleIds[9], courseIds[5], true, 14],
      [jobRoleIds[8], courseIds[0], true, 7],
      [jobRoleIds[8], courseIds[3], true, 7],
      [jobRoleIds[8], courseIds[1], true, 14],
      [jobRoleIds[3], courseIds[3], true, 14],
      [jobRoleIds[10], courseIds[1], true, 14],
    ];
    for (final m in matrixData) {
      await TrainingMatrix.db.insertRow(
        session,
        TrainingMatrix(
          jobRoleId: m[0] as int,
          courseId: m[1] as int,
          siteId: siteId,
          isMandatory: m[2] as bool,
          dueDaysFromHire: m[3] as int,
          approvedById: qaId,
          effectiveDate: dt(-180),
        ),
      );
    }

    // Phase 6: Training assignments and enrollments
    final enrollData = [
      [aliceId, cvGmpV2Id, 'in_progress', -20, 10, 'onboarding'],
      [aliceId, cvColdchainV2Id, 'overdue', -40, -8, 'onboarding'],
      [aliceId, cvAsepticV1Id, 'completed', -320, -290, 'onboarding', -310],
      [aliceId, cvGmpV2Id, 'not_started', null, 14, 'sop_update'],
      [bobId, cvGmpV2Id, 'completed', -200, -180, 'onboarding', -195],
      [bobId, cvColdchainV2Id, 'completed', -180, -150, 'onboarding', -170],
      [bobId, cvSafetyV1Id, 'completed', -160, -130, 'onboarding', -155],
      [carolId, cvGmpV2Id, 'not_started', null, 0, 'onboarding'],
      [carolId, cvAsepticV1Id, 'not_started', null, 7, 'onboarding'],
      [daveId, cvColdchainV2Id, 'in_progress', -30, -5, 'onboarding'],
      [daveId, cvGmpV2Id, 'completed', -280, -250, 'onboarding', -270],
    ];
    final enrollmentIds = <int>[];
    final assignmentIds = <int>[];
    for (var i = 0; i < enrollData.length; i++) {
      final e = enrollData[i];
      final dueDate = dt(e[4] as int);
      final startedAt = e[3] != null ? dt(e[3] as int) : null;
      final completedAt = e.length > 6 ? dt(e[6] as int) : null;
      final assignedById = e[5] == 'sop_update' ? adminId : adminId;
      final assign = await TrainingAssignment.db.insertRow(
        session,
        TrainingAssignment(
          userId: e[0] as int,
          courseVersionId: e[1] as int,
          assignedById: assignedById,
          assignedAt: dt(-30 - i),
          dueDate: dueDate,
          priority: e[2] == 'overdue' ? 'high' : 'medium',
          source: e[5] as String,
          reason: e[5] == 'sop_update' ? 'SOP updated to v2.0 — retraining required' : 'Required per training matrix',
        ),
      );
      assignmentIds.add(assign.id!);
      final enr = await Enrollment.db.insertRow(
        session,
        Enrollment(
          userId: e[0] as int,
          courseVersionId: e[1] as int,
          assignmentId: assign.id!,
          status: e[2] as String,
          startedAt: startedAt,
          completedAt: completedAt,
        ),
      );
      enrollmentIds.add(enr.id!);
    }
    final aliceEnrGmp = enrollmentIds[0];
    final aliceEnrAseptic = enrollmentIds[2];
    final bobEnrGmp = enrollmentIds[4];
    final bobEnrCc = enrollmentIds[5];
    final bobEnrSafety = enrollmentIds[6];
    final daveEnrGmp = enrollmentIds[10];
    final daveEnrCc = enrollmentIds[9];

    for (var i = 0; i < 18; i++) {
      final uid = userIds['employee${(i + 1).toString().padLeft(2, '0')}@pharmacorp.demo']!;
      final statuses = ['completed', 'completed', 'completed', 'in_progress', 'overdue', 'not_started', 'overdue', 'completed', 'completed', 'in_progress'];
      final s = statuses[i % statuses.length];
      final dueDate = s == 'overdue' ? dt(-3) : dt(15);
      final startedAt = s != 'not_started' ? dt(-(30 + i * 5)) : null;
      final completedAt = s == 'completed' ? dt(-(20 + i * 3)) : null;
      final assign = await TrainingAssignment.db.insertRow(
        session,
        TrainingAssignment(
          userId: uid,
          courseVersionId: cvGmpV2Id,
          assignedById: adminId,
          assignedAt: dt(-30 - i),
          dueDate: dueDate,
          source: 'onboarding',
        ),
      );
      await Enrollment.db.insertRow(
        session,
        Enrollment(
          userId: uid,
          courseVersionId: cvGmpV2Id,
          assignmentId: assign.id!,
          status: s,
          startedAt: startedAt,
          completedAt: completedAt,
        ),
      );
    }

    // Phase 6: Assessment attempts
    const hmacSecret = 'DEMO_HMAC_SECRET_KEY_NOT_FOR_PRODUCTION_2026';
    String hmac(String data) {
      final key = utf8.encode(hmacSecret);
      final bytes = utf8.encode(data);
      final digest = Hmac(sha256, key).convert(bytes);
      return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    }

    final attemptData = [
      [aliceId, assessIds[2], aliceEnrAseptic, 90, true, -311],
      [bobId, assessIds[0], bobEnrGmp, 85, true, -196],
      [bobId, assessIds[1], bobEnrCc, 80, true, -171],
      [bobId, assessIds[3], bobEnrSafety, 92, true, -156],
      [daveId, assessIds[0], daveEnrGmp, 82, true, -271],
      [daveId, assessIds[1], daveEnrCc, 60, false, -20],
      [daveId, assessIds[1], daveEnrCc, 70, false, -10],
    ];
    final attemptIds = <int>[];
    for (final a in attemptData) {
      final att = await AssessmentAttempt.db.insertRow(
        session,
        AssessmentAttempt(
          userId: a[0] as int,
          assessmentId: a[1] as int,
          enrollmentId: a[2] as int,
          startedAt: dt(a[5] as int),
          completedAt: dt(a[5] as int),
          score: a[3] as int,
        ),
      );
      attemptIds.add(att.id!);
      final qIds = questionIdsByAssess[a[1] as int] ?? [];
      for (var qi = 0; qi < 10 && qi < qIds.length; qi++) {
        final correct = qi < (a[3] as int) ~/ 10;
        await AssessmentResult.db.insertRow(
          session,
          AssessmentResult(
            attemptId: att.id!,
            questionId: qIds[qi],
            answer: correct ? '0' : '1',
            correct: correct,
          ),
        );
      }
    }

    // Phase 7: E-signatures, certificates, training records
    final meaningTraining = 'I have completed this training and attest that I have read, understood, and will apply the content to my work.';
    final esigData = [
      [aliceId, aliceEnrAseptic, meaningTraining, -310, false],
      [bobId, bobEnrGmp, meaningTraining, -195, false],
      [bobId, bobEnrCc, meaningTraining, -170, false],
      [bobId, bobEnrSafety, meaningTraining, -155, false],
      [daveId, daveEnrGmp, meaningTraining, -270, false],
      [aliceId, aliceEnrAseptic, meaningTraining, -100, true],
    ];
    final esigIds = <int>[];
    for (final e in esigData) {
      final ts = dt(e[3] as int);
      final tampered = e[4] as bool;
      final data = '${e[0]}:${e[1]}:$ts:enrollment';
      final hash = tampered ? '${hmac(data)}x' : hmac(data);
      final esig = await ElectronicSignature.db.insertRow(
        session,
        ElectronicSignature(
          userId: e[0] as int,
          timestamp: ts,
          signatureMeaning: e[2] as String,
          entityType: 'enrollment',
          entityId: (e[1] as int).toString(),
          ipAddress: '10.0.1.100',
          integrityHash: hash,
        ),
      );
      esigIds.add(esig.id!);
    }
    final esigAliceAseptic = esigIds[0];
    final esigTampered = esigIds[5];

    final trData = [
      [aliceEnrAseptic, aliceId, cvAsepticV1Id, esigAliceAseptic, -310, 90],
      [bobEnrGmp, bobId, cvGmpV2Id, esigIds[1], -195, 85],
      [bobEnrCc, bobId, cvColdchainV2Id, esigIds[2], -170, 80],
      [bobEnrSafety, bobId, cvSafetyV1Id, esigIds[3], -155, 92],
      [daveEnrGmp, daveId, cvGmpV2Id, esigIds[4], -270, 82],
    ];
    final trIds = <int>[];
    for (final t in trData) {
      final tr = await TrainingRecord.db.insertRow(
        session,
        TrainingRecord(
          enrollmentId: t[0],
          userId: t[1],
          courseVersionId: t[2],
          completedAt: dt(t[4]),
          score: t[5],
          esignatureId: t[3],
        ),
      );
      trIds.add(tr.id!);
    }

    final certData = [
      [aliceId, cvAsepticV1Id, trIds[0], esigAliceAseptic, -310, 55, 'active'],
      [aliceId, cvIds[0], null, esigTampered, -100, null, 'obsolete'],
      [bobId, cvGmpV2Id, trIds[1], esigIds[1], -195, 170, 'active'],
      [bobId, cvColdchainV2Id, trIds[2], esigIds[2], -170, 195, 'active'],
      [bobId, cvSafetyV1Id, trIds[3], esigIds[3], -155, 210, 'active'],
      [daveId, cvGmpV2Id, trIds[4], esigIds[4], -270, 95, 'active'],
    ];
    for (final c in certData) {
      await Certificate.db.insertRow(
        session,
        Certificate(
          userId: c[0] as int,
          courseVersionId: c[1] as int,
          trainingRecordId: (c[2] as int?) ?? trIds[0],
          esignatureId: c[3] as int,
          issuedAt: dt(c[4] as int),
          expiresAt: c[5] != null ? dt(c[5] as int) : null,
          status: c[6] as String,
        ),
      );
    }

    // Phase 8: Quality events, CAPAs, waivers, inspection
    final qeData = [
      ['Temperature Excursion in Cold Storage Unit 3', 'deviation', 'critical', dt(-20)],
      ['OOS Result: Batch 2024-MFG-007 Potency Test', 'oos', 'major', dt(-35)],
      ['Gowning Procedure Non-Compliance — Clean Room Entry', 'deviation', 'critical', dt(-5)],
      ['Label Reconciliation Discrepancy — Batch 2024-PKG-012', 'deviation', 'minor', dt(-60)],
      ['Equipment Calibration Overdue — Spectrophotometer', 'deviation', 'major', dt(-45)],
      ['SOP Non-Compliance: Aseptic Fill Line Procedure', 'deviation', 'critical', dt(-90)],
      ['Data Entry Error in Batch Record 2024-QC-018', 'deviation', 'minor', dt(-15)],
      ['Customer Complaint: Foreign Particle in Product', 'complaint', 'critical', dt(-3)],
    ];
    final qeIds = <int>[];
    for (final q in qeData) {
      final qe = await QualityEvent.db.insertRow(
        session,
        QualityEvent(
          eventType: q[1] as String,
          title: q[0] as String,
          status: 'open',
          siteId: siteId,
          createdAt: q[3] as DateTime,
        ),
      );
      qeIds.add(qe.id!);
    }

    final capaData = [
      [qeIds[1], 'ActionPlanApproved'],
      [qeIds[4], 'Verification'],
      [qeIds[5], 'Closed'],
      [qeIds[0], 'Initiation'],
    ];
    for (final capa in capaData) {
      await Capa.db.insertRow(
        session,
        Capa(
          qualityEventId: capa[0] as int,
          status: capa[1] as String,
          description: 'Root cause: insufficient training. Corrective action: retraining assigned.',
          rootCause: 'Insufficient training on updated SOP',
          trainingRequired: true,
        ),
      );
    }

    await TrainingWaiver.db.insertRow(
      session,
      TrainingWaiver(
        userId: bobId,
        courseId: courseIds[2],
        requestedById: adminId,
        requestReason: 'Equivalent qualification from previous employer — BSc Pharmacy, RQAP-GCP certified.',
        evidenceStoragePath: 'waivers/waiver-001/evidence.pdf',
        status: 'approved',
        approvedById: qaId,
        approvedAt: dt(-80),
        expiresAt: dt(285),
      ),
    );

    final insp = await InspectionRecord.db.insertRow(
      session,
      InspectionRecord(
        inspectionType: 'fda',
        inspectorNames: 'Inspector John Smith',
        scopeDescription: 'Training Records, Electronic Signatures, CAPA, Data Integrity',
        siteId: siteId,
        status: 'active',
        inspectionAccessToken: 'DEMO_TOKEN_2026',
        tokenExpiresAt: dt(1),
        briefingPackHash: 'sha256-inspection-briefing',
        createdById: adminId,
        createdAt: dt(-5),
      ),
    );

    await AuditorSession.db.insertRow(
      session,
      AuditorSession(
        inspectionRecordId: insp.id!,
        accessType: 'token',
        accessToken: 'DEMO_TOKEN_2026',
        tokenIssuedAt: dt(0),
        tokenExpiresAt: dt(1),
        isActive: true,
        pagesViewedCount: 0,
      ),
    );

    // Phase 9: DLQ, scheduled jobs, audit trail, notifications
    await DeadLetterQueue.db.insertRow(
      session,
      DeadLetterQueue(
        failureReason: 'Kafka broker connection timeout after 3 retries.',
        retryCount: 3,
        manuallyResolved: false,
        failedAt: dt(-14),
      ),
    );

    final now = dt(0);
    final jobData = [
      ['ComplianceCalc', now.add(const Duration(minutes: -2)), 'completed', 312, 28, null],
      ['CertExpiryCheck', now.add(const Duration(minutes: -2)), 'completed', 156, 3, null],
      ['NotificationWorker', now.add(const Duration(minutes: -1)), 'completed', 88, 12, null],
      ['AuditTrailIntegrityCheck', now.add(const Duration(minutes: -2)), 'completed', 512, 0, null],
      ['CapaEffectivenessCheck', now.add(const Duration(minutes: -2)), 'completed', 4, 1, null],
      ['HRISSync', now.add(const Duration(minutes: -2)), 'failed', 45, 0, 'Connection timeout to HRIS API'],
    ];
    for (final j in jobData) {
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: j[0] as String,
          startedAt: j[1] as DateTime,
          completedAt: (j[1] as DateTime).add(const Duration(minutes: 2)),
          status: j[2] as String,
          recordsProcessed: j[3] as int,
          recordsAffected: j[4] as int,
          errorDetails: j[5] as String?,
        ),
      );
    }

    for (var i = 0; i < 100; i++) {
      await AuditTrail.db.insertRow(
        session,
        AuditTrail(
          entityType: ['Enrollment', 'Certificate', 'MaterialProgress', 'Notification', 'Report'][i % 5],
          entityId: 'entity-${i.toString().padLeft(4, '0')}',
          action: ['page_view', 'data_export', 'report_generated', 'notification_sent', 'enrollment_updated'][i % 5],
          timestamp: dt(-(i ~/ 2)),
          userId: [aliceId, bobId, adminId, qaId, smeId][i % 5],
          ipAddress: '10.0.1.${100 + (i % 50)}',
        ),
      );
    }

    final notifData = [
      [aliceId, 'assignment', aliceEnrGmp, dt(-30), 'delivered'],
      [aliceId, 'overdue_employee', enrollmentIds[1], dt(-7), 'delivered'],
      [carolId, 'assignment', enrollmentIds[7], dt(-7), 'delivered'],
      [daveId, 'assessment_failed', daveEnrCc, dt(-10), 'delivered'],
    ];
    for (final n in notifData) {
      await Notification.db.insertRow(
        session,
        Notification(
          userId: n[0] as int,
          type: n[1] as String,
          enrollmentId: n[2] as int,
          sentAt: n[3] as DateTime,
          deliveryStatus: n[4] as String,
          channel: 'email',
        ),
      );
    }

    return 'MVP seed completed: 1 org, 3 sites, 8 depts, 12 job roles, 32 users, 6 courses, 18 modules, 54 lessons, 6 assessments, training matrix, assignments, enrollments, e-signatures, certificates, quality events, CAPAs, waivers, audit trail, notifications.';
  }
}
