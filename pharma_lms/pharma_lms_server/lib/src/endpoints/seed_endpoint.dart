import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';

/// Default password for all seed/demo users.
/// In production, users would register with their own passwords.
const _seedPassword = 'Pharma@2024!Secure';

/// Seed endpoint for development/demo data.
/// Provides comprehensive seed data for PharmaTech India with full FRD compliance.
class SeedEndpoint extends Endpoint {
  /// Legacy seed method - delegates to comprehensive seed
  Future<String> runSeed(Session session) async {
    return runComprehensiveSeed(session);
  }

  /// Legacy MVP seed method - delegates to comprehensive seed
  Future<String> runMvpSeed(Session session) async {
    return runComprehensiveSeed(session);
  }

  /// Clear all seed data and re-run comprehensive seed
  Future<String> clearAndReseed(Session session) async {
    // Delete in reverse dependency order
    final messages = <String>[];

    // Delete existing PharmaTech organization and all related data
    final existingOrg = await Organization.db.findFirstRow(
      session,
      where: (t) => t.name.equals('PharmaTech India Pvt Ltd'),
    );

    if (existingOrg != null) {
      await _deleteExistingOrgData(session, existingOrg.id!);
      messages.add('Deleted organization and all related data: PharmaTech India Pvt Ltd');
    } else {
      messages.add('No existing PharmaTech India organization found');
    }

    // Now run the comprehensive seed
    final seedResult = await runComprehensiveSeed(session);
    messages.add(seedResult);

    return messages.join('\\n');
  }

  /// Comprehensive seed with 100 learners, 15 trainers, 12 pharma courses,
  /// Full compliance: HMAC signatures, assessment attempts,
  /// training matrix, material progress tracking.
  Future<String> runComprehensiveSeed(Session session) async {
    final baseDate = DateTime(2026, 3, 14);
    DateTime dt(int offsetDays) => baseDate.add(Duration(days: offsetDays));

    // First delete existing data if organization exists
    final existing = await Organization.db.findFirstRow(
      session,
      where: (t) => t.name.equals('PharmaTech India Pvt Ltd'),
    );
    if (existing != null) {
      await _deleteExistingOrgData(session, existing.id!);
    }

    // HMAC secret for integrity hashes (FR-02-02 AC-06)
    const hmacSecret = 'pharma-lms-super-secret-audit-key-2026';

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 1: Organization & Sites
    // ═══════════════════════════════════════════════════════════════════════════
    final org = await Organization.db.insertRow(
      session,
      Organization(name: 'PharmaTech India Pvt Ltd', code: 'PTI'),
    );
    final orgId = org.id!;

    final siteData = [
      ['Mumbai HQ', 'MUM', 'Asia/Kolkata'],
      ['Pune Manufacturing', 'PUN', 'Asia/Kolkata'],
      ['Hyderabad R&D', 'HYD', 'Asia/Kolkata'],
      ['Ahmedabad API', 'AHM', 'Asia/Kolkata'],
      ['Bengaluru Biotech', 'BLR', 'Asia/Kolkata'],
    ];
    final siteIds = <int>[];
    for (final s in siteData) {
      final site = await Site.db.insertRow(
        session,
        Site(organizationId: orgId, name: s[0], code: s[1], timezone: s[2]),
      );
      siteIds.add(site.id!);
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 2: Departments
    // ═══════════════════════════════════════════════════════════════════════════
    final deptData = [
      ['Quality Assurance', 'QA'],
      ['Quality Control', 'QC'],
      ['Manufacturing', 'MFG'],
      ['Regulatory Affairs', 'RA'],
      ['Pharmacovigilance', 'PV'],
      ['Research & Development', 'RD'],
      ['Information Technology', 'IT'],
      ['Learning & Development', 'LD'],
      ['Supply Chain', 'SCM'],
      ['Engineering', 'ENG'],
    ];
    final deptIds = <int>[];
    for (final d in deptData) {
      final dept = await Department.db.insertRow(
        session,
        Department(siteId: siteIds[0], name: d[0], code: d[1]),
      );
      deptIds.add(dept.id!);
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 3: Roles
    // ═══════════════════════════════════════════════════════════════════════════
    final roleData = [
      ['Admin', 'admin'],
      ['QA Director', 'qa_director'],
      ['QA Manager', 'qa_manager'],
      ['Trainer', 'trainer'],
      ['SME', 'sme'],
      ['Employee', 'employee'],
      ['Auditor', 'auditor'],
    ];
    final roleIds = <String, int>{};
    for (final r in roleData) {
      final existing =
          await Role.db.findFirstRow(session, where: (t) => t.code.equals(r[1]));
      if (existing != null) {
        roleIds[r[1]] = existing.id!;
      } else {
        final role =
            await Role.db.insertRow(session, Role(name: r[0], code: r[1]));
        roleIds[r[1]] = role.id!;
      }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 3b: Permissions (RBAC resource:action per role)
    // ═══════════════════════════════════════════════════════════════════════════
    // Format: [roleCode, resource, action]
    final permissionData = <List<String>>[
      // Admin — full access
      ['admin', '*', '*'],

      // QA Director — full read, write quality_event & compliance
      ['qa_director', '*', 'read'],
      ['qa_director', 'quality_event', 'write'],
      ['qa_director', 'compliance', 'write'],
      ['qa_director', 'course', 'write'],

      // QA Manager — same as director
      ['qa_manager', '*', 'read'],
      ['qa_manager', 'quality_event', 'write'],
      ['qa_manager', 'compliance', 'write'],
      ['qa_manager', 'course', 'write'],

      // Trainer — course, material, assessment, training, analytics, audit, document (SOP library)
      ['trainer', 'course', 'read'],
      ['trainer', 'course', 'write'],
      ['trainer', 'material', 'read'],
      ['trainer', 'material', 'write'],
      ['trainer', 'assessment', 'read'],
      ['trainer', 'assessment', 'write'],
      ['trainer', 'training', 'read'],
      ['trainer', 'training', 'write'],
      ['trainer', 'training', 'assign'],
      ['trainer', 'analytics', 'read'],
      ['trainer', 'analytics', 'write'],
      ['trainer', 'audit', 'read'],
      ['trainer', 'organization', 'read'],
      ['trainer', 'compliance', 'read'],
      ['trainer', 'quality_event', 'read'],
      ['trainer', 'document', 'read'],
      ['trainer', 'document', 'write'],

      // SME — same as trainer (including document for SOP library)
      ['sme', 'course', 'read'],
      ['sme', 'course', 'write'],
      ['sme', 'material', 'read'],
      ['sme', 'material', 'write'],
      ['sme', 'assessment', 'read'],
      ['sme', 'assessment', 'write'],
      ['sme', 'training', 'read'],
      ['sme', 'training', 'write'],
      ['sme', 'training', 'assign'],
      ['sme', 'analytics', 'read'],
      ['sme', 'audit', 'read'],
      ['sme', 'organization', 'read'],
      ['sme', 'compliance', 'read'],
      ['sme', 'document', 'read'],
      ['sme', 'document', 'write'],

      // Employee — read training, compliance, analytics, organization
      ['employee', 'training', 'read'],
      ['employee', 'compliance', 'read'],
      ['employee', 'analytics', 'read'],
      ['employee', 'organization', 'read'],
      ['employee', 'course', 'read'],
      ['employee', 'material', 'read'],
      ['employee', 'assessment', 'read'],

      // Auditor — read everything
      ['auditor', '*', 'read'],
      ['auditor', 'audit', 'read'],
    ];

    for (final p in permissionData) {
      final roleId = roleIds[p[0]];
      if (roleId != null) {
        final exists = await Permission.db.findFirstRow(
          session,
          where: (t) =>
              t.roleId.equals(roleId) &
              t.resource.equals(p[1]) &
              t.action.equals(p[2]),
        );
        if (exists == null) {
          await Permission.db.insertRow(
            session,
            Permission(roleId: roleId, resource: p[1], action: p[2]),
          );
        }
      }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 4: Job Roles
    // ═══════════════════════════════════════════════════════════════════════════
    final jobRoleData = [
      ['QA Specialist', 'QA-SPEC', 0],
      ['QC Analyst', 'QC-ANAL', 1],
      ['Production Operator', 'PROD-OP', 2],
      ['Line Supervisor', 'LINE-SUP', 2],
      ['Plant Manager', 'PLANT-MGR', 2],
      ['Regulatory Manager', 'RA-MGR', 3],
      ['PV Associate', 'PV-ASSOC', 4],
      ['Research Scientist', 'RD-SCI', 5],
      ['IT Engineer', 'IT-ENG', 6],
      ['CSV Specialist', 'CSV-SPEC', 6],
      ['Training Coordinator', 'TRN-COORD', 7],
      ['Instructional Designer', 'INST-DES', 7],
      ['Warehouse Operator', 'WH-OP', 8],
      ['Validation Engineer', 'VAL-ENG', 9],
    ];
    final jobRoleIds = <int>[];
    for (final j in jobRoleData) {
      final jr = await JobRole.db.insertRow(
        session,
        JobRole(
          departmentId: deptIds[j[2] as int],
          name: j[0] as String,
          code: j[1] as String,
        ),
      );
      jobRoleIds.add(jr.id!);
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 4b: Signature Meanings (FR-02-01)
    // ═══════════════════════════════════════════════════════════════════════════
    final meaningCompletion = await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning: 'I certify that I have completed this training and will apply the content to my work',
        isActive: true,
        orderIndex: 0,
      ),
    );
    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning: 'I approve this course version as accurate and compliant',
        isActive: true,
        orderIndex: 1,
      ),
    );
    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning: 'I certify this CAPA is effectively closed and verified',
        isActive: true,
        orderIndex: 2,
      ),
    );
    await SignatureMeaning.db.insertRow(
      session,
      SignatureMeaning(
        meaning: 'I approve this SOP document version',
        isActive: true,
        orderIndex: 3,
      ),
    );

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 5: Trainers (15)
    // ═══════════════════════════════════════════════════════════════════════════
    final trainerData = [
      ['rajesh.venkataraman@pharmatech.in', 'Dr. Rajesh', 'Venkataraman', 'TRN-001', 0, 0, 0],
      ['sneha.krishnamurthy@pharmatech.in', 'Sneha', 'Krishnamurthy', 'TRN-002', 0, 7, 11],
      ['kavitha.subramaniam@pharmatech.in', 'Dr. Kavitha', 'Subramaniam', 'TRN-003', 1, 2, 4],
      ['arun.nair@pharmatech.in', 'Arun', 'Nair', 'TRN-004', 2, 3, 5],
      ['priya.sharma@pharmatech.in', 'Priya', 'Sharma', 'TRN-005', 1, 2, 3],
      ['vikram.reddy@pharmatech.in', 'Vikram', 'Reddy', 'TRN-006', 0, 6, 9],
      ['meera.patel@pharmatech.in', 'Dr. Meera', 'Patel', 'TRN-007', 2, 4, 6],
      ['ankit.joshi@pharmatech.in', 'Ankit', 'Joshi', 'TRN-008', 4, 7, 10],
      ['lakshmi.iyer@pharmatech.in', 'Lakshmi', 'Iyer', 'TRN-009', 3, 0, 0],
      ['rahul.deshmukh@pharmatech.in', 'Rahul', 'Deshmukh', 'TRN-010', 1, 1, 1],
      ['deepa.menon@pharmatech.in', 'Deepa', 'Menon', 'TRN-011', 0, 7, 11],
      ['suresh.kumar@pharmatech.in', 'Suresh', 'Kumar', 'TRN-012', 2, 5, 7],
      ['anjali.rao@pharmatech.in', 'Anjali', 'Rao', 'TRN-013', 4, 9, 13],
      ['karthik.pillai@pharmatech.in', 'Karthik', 'Pillai', 'TRN-014', 3, 2, 3],
      ['divya.bhat@pharmatech.in', 'Divya', 'Bhat', 'TRN-015', 0, 3, 5],
    ];
    final trainerIds = <int>[];
    for (final t in trainerData) {
      final user = await PharmaUser.db.insertRow(
        session,
        PharmaUser(
          email: t[0] as String,
          firstName: t[1] as String,
          lastName: t[2] as String,
          employeeId: t[3] as String,
          siteId: siteIds[t[4] as int],
          departmentId: deptIds[t[5] as int],
          jobRoleId: jobRoleIds[t[6] as int],
          organizationId: orgId,
          status: 'active',
          hireDate: dt(-800 + trainerIds.length * 30),
        ),
      );
      trainerIds.add(user.id!);
      await UserRole.db.insertRow(
        session,
        UserRole(userId: user.id!, roleId: roleIds['trainer']!),
      );
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 6: Learners (100)
    // ═══════════════════════════════════════════════════════════════════════════
    final learnerNames = [
      ['Ramesh', 'Gupta'], ['Priyanka', 'Singh'], ['Manoj', 'Verma'],
      ['Sunita', 'Devi'], ['Arvind', 'Khanna'], ['Fatima', 'Khan'],
      ['Sanjay', 'Patil'], ['Neha', 'Agarwal'], ['Vishal', 'Jain'],
      ['Asha', 'Kumari'], ['Amit', 'Sharma'], ['Pooja', 'Patel'],
      ['Ravi', 'Kumar'], ['Swati', 'Reddy'], ['Deepak', 'Nair'],
      ['Kavita', 'Iyer'], ['Sunil', 'Rao'], ['Anjali', 'Mehta'],
      ['Rajiv', 'Desai'], ['Shweta', 'Joshi'], ['Vinod', 'Pillai'],
      ['Rekha', 'Menon'], ['Ashok', 'Bhat'], ['Nidhi', 'Gupta'],
      ['Prakash', 'Singh'], ['Seema', 'Verma'], ['Anil', 'Chauhan'],
      ['Geeta', 'Saxena'], ['Mohan', 'Tiwari'], ['Sarita', 'Pandey'],
      ['Vikram', 'Malhotra'], ['Lalita', 'Kapoor'], ['Suresh', 'Bhatt'],
      ['Rina', 'Shah'], ['Gaurav', 'Mishra'], ['Preeti', 'Sinha'],
      ['Naresh', 'Yadav'], ['Usha', 'Tripathi'], ['Kishore', 'Chandra'],
      ['Madhuri', 'Das'], ['Satish', 'Sen'], ['Padma', 'Roy'],
      ['Dilip', 'Banerjee'], ['Manju', 'Ghosh'], ['Rakesh', 'Mukherjee'],
      ['Veena', 'Dutta'], ['Harish', 'Paul'], ['Radha', 'Bose'],
      ['Srinivas', 'Chakraborty'], ['Kamala', 'Chatterjee'],
      ['Girish', 'Majumdar'], ['Lata', 'Sarkar'], ['Mahesh', 'Saha'],
      ['Suman', 'Biswas'], ['Pankaj', 'De'], ['Anu', 'Kar'],
      ['Vivek', 'Mitra'], ['Jaya', 'Dey'], ['Nitin', 'Ganguly'],
      ['Sunanda', 'Lahiri'], ['Hemant', 'Nandy'], ['Asha', 'Bhattacharya'],
      ['Alok', 'Sengupta'], ['Meenakshi', 'Basu'], ['Raghav', 'Ray'],
      ['Sudha', 'Mandal'], ['Sanjiv', 'Goswami'], ['Urmila', 'Chowdhury'],
      ['Vijay', 'Adhikari'], ['Chitra', 'Barman'], ['Ajay', 'Choudhury'],
      ['Kiran', 'Haldar'], ['Manish', 'Bhowmik'], ['Shobha', 'Kundu'],
      ['Dinesh', 'Mondal'], ['Anita', 'Jana'], ['Rohit', 'Ghosal'],
      ['Pushpa', 'Pal'], ['Santosh', 'Hazra'], ['Mamta', 'Konar'],
      ['Prem', 'Samanta'], ['Renu', 'Maity'], ['Ashish', 'Naskar'],
      ['Beena', 'Shil'], ['Mukesh', 'Halder'], ['Saroj', 'Basak'],
      ['Arvind', 'Debnath'], ['Kalpana', 'Sanyal'], ['Yogesh', 'Roychowdhury'],
      ['Jyoti', 'Mukhopadhyay'],
    ];
    final learnerIds = <int>[];
    for (var i = 0; i < 100; i++) {
      final nameData = learnerNames[i < learnerNames.length ? i : i % learnerNames.length];
      final user = await PharmaUser.db.insertRow(
        session,
        PharmaUser(
          email: '${nameData[0].toLowerCase()}.${nameData[1].toLowerCase()}${i > 0 ? i : ''}@pharmatech.in',
          firstName: nameData[0],
          lastName: nameData[1],
          employeeId: 'EMP-${(1000 + i).toString()}',
          siteId: siteIds[i % 5],
          departmentId: deptIds[i % 10],
          jobRoleId: jobRoleIds[i % 14],
          organizationId: orgId,
          status: i == 99 ? 'terminated' : (i % 50 == 49 ? 'locked' : 'active'),
          hireDate: dt(-1800 + i * 15),
        ),
      );
      learnerIds.add(user.id!);
      await UserRole.db.insertRow(
        session,
        UserRole(userId: user.id!, roleId: roleIds['employee']!),
      );
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 6a: Admin Users (5) — for comprehensive admin portal testing
    // ═══════════════════════════════════════════════════════════════════════════
    final adminUsers = <List<dynamic>>[
      // [email, firstName, lastName, employeeId, siteId_idx, deptId_idx, roleCode]
      ['superadmin@pharmatech.in', 'Super', 'Administrator', 'ADM-001', 0, 0, 'admin'],
      ['contentadmin@pharmatech.in', 'Content', 'Administrator', 'ADM-002', 0, 7, 'admin'],
      ['qamanager@pharmatech.in', 'Quality', 'Manager', 'ADM-003', 1, 0, 'qa_manager'],
      ['trainingadmin@pharmatech.in', 'Training', 'Administrator', 'ADM-004', 2, 7, 'admin'],
      ['auditofficer@pharmatech.in', 'Audit', 'Officer', 'ADM-005', 4, 3, 'auditor'],
    ];
    
    for (final a in adminUsers) {
      // Check if admin user already exists
      final existingAdmin = await PharmaUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(a[0] as String),
      );
      if (existingAdmin == null) {
        final adminUser = await PharmaUser.db.insertRow(
          session,
          PharmaUser(
            email: a[0] as String,
            firstName: a[1] as String,
            lastName: a[2] as String,
            employeeId: a[3] as String,
            siteId: siteIds[a[4] as int],
            departmentId: deptIds[a[5] as int],
            jobRoleId: jobRoleIds[0], // Placeholder job role
            organizationId: orgId,
            status: 'active',
            hireDate: dt(-730), // 2 years ago (long tenure for admins)
          ),
        );
        await UserRole.db.insertRow(
          session,
          UserRole(userId: adminUser.id!, roleId: roleIds[a[6] as String]!),
        );
      }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 7: Courses (12)
    // ═══════════════════════════════════════════════════════════════════════════
    final courseConfigs = [
      ['GMP Fundamentals', 'SOP-GMP-001', '21 CFR Part 211'],
      ['21 CFR Part 11', 'SOP-EREC-002', 'Electronic records compliance'],
      ['GCP — ICH E6 R2', 'SOP-GCP-003', 'Good Clinical Practice'],
      ['GVP Modules', 'SOP-GVP-004', 'Good Pharmacovigilance Practice'],
      ['Cold Chain Management', 'SOP-COLD-005', 'WHO TRS 961'],
      ['Aseptic Technique', 'SOP-ASEP-006', 'EU GMP Annex 1'],
      ['CAPA & Root Cause', 'SOP-CAPA-007', 'Corrective and Preventive Action'],
      ['Data Integrity', 'SOP-DI-008', 'ALCOA+ principles'],
      ['EHS Fundamentals', 'SOP-EHS-009', 'OSHA 29 CFR 1910'],
      ['Stability Studies', 'SOP-STAB-010', 'ICH Q1A R2'],
      ['Audit Readiness', 'SOP-AUDIT-011', 'FDA/EMA inspection prep'],
      ['New Employee Induction', 'SOP-INDUCT-012', 'Company policies'],
    ];
    final courseVersionIds = <int>[];
    final assessmentIds = <int>[];

    for (var i = 0; i < courseConfigs.length; i++) {
      final c = courseConfigs[i];
      final course = await Course.db.insertRow(
        session,
        Course(
          title: c[0],
          sopNumber: c[1],
          description: c[2],
          status: 'approved',
          createdById: trainerIds[i % trainerIds.length],
          organizationId: orgId,
        ),
      );
      final cv = await CourseVersion.db.insertRow(
        session,
        CourseVersion(
          courseId: course.id!,
          version: '1.0',
          status: 'effective',
          effectiveDate: dt(-180 + i * 10),
        ),
      );
      courseVersionIds.add(cv.id!);

      // Training Matrix
      await TrainingMatrix.db.insertRow(
        session,
        TrainingMatrix(
          jobRoleId: jobRoleIds[i % jobRoleIds.length],
          courseId: course.id!,
          isMandatory: true,
          dueDaysFromHire: 30,
          effectiveDate: dt(-180),
        ),
      );

      // Question Bank & Assessment
      final qb = await QuestionBank.db.insertRow(
        session,
        QuestionBank(name: '${c[0]} Quiz', organizationId: orgId),
      );
      for (var qi = 0; qi < 5; qi++) {
        await Question.db.insertRow(
          session,
          Question(
            questionBankId: qb.id!,
            text: 'Question ${qi + 1} for ${c[0]}',
            questionType: qi % 2 == 0 ? 'multiple_choice' : 'true_false',
            optionsJson: qi % 2 == 0 ? '["A","B","C","D"]' : '["True","False"]',
            correctAnswer: '0',
            difficulty: ['easy', 'medium', 'hard'][qi % 3],
            regulatoryTag: 'GMP',
          ),
        );
      }
      final assessment = await Assessment.db.insertRow(
        session,
        Assessment(
          courseVersionId: cv.id!,
          questionBankId: qb.id!,
          passingScore: 80,
          timeLimitMinutes: 30,
          maxAttempts: 3,
        ),
      );
      assessmentIds.add(assessment.id!);

      // Modules & Lessons
      for (var mi = 0; mi < 3; mi++) {
        final mod = await Module.db.insertRow(
          session,
          Module(courseVersionId: cv.id!, title: 'Module ${mi + 1}', orderIndex: mi),
        );
        for (var li = 0; li < 3; li++) {
          final mat = await Material.db.insertRow(
            session,
            Material(
              title: 'Lesson ${li + 1} Material',
              materialType: li == 2 ? 'video' : 'pdf',
              storageKey: 's3://pharma-lms/${c[1]}/m${mi + 1}/l${li + 1}.${li == 2 ? 'mp4' : 'pdf'}',
              organizationId: orgId,
            ),
          );
          await Lesson.db.insertRow(
            session,
            Lesson(
              moduleId: mod.id!,
              title: 'Lesson ${li + 1}',
              orderIndex: li,
              materialId: mat.id!,
              durationMinutes: 10 + li * 5,
            ),
          );
        }
      }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 8: Enrollments & Certificates
    // ═══════════════════════════════════════════════════════════════════════════
    var assignmentCount = 0;
    var completedCount = 0;
    var overdueCount = 0;
    final enrollmentIds = <int>[];
    var certificateCount = 0;

    for (var ui = 0; ui < 50; ui++) {
      final userId = learnerIds[ui];
      final assignerId = trainerIds[ui % trainerIds.length];

      for (var ci = 0; ci < courseVersionIds.length; ci++) {
        final cvId = courseVersionIds[ci];
        final daysOffset = -90 + (ui % 60) - ci * 5;
        final statusRoll = (ui * 7 + ci * 13) % 100;
        final isCompleted = statusRoll < 40;
        final isInProgress = statusRoll >= 40 && statusRoll < 65;
        final isOverdue = statusRoll >= 85;

        if (isOverdue) overdueCount++;
        if (isCompleted) completedCount++;

        final completedAt = isCompleted ? dt(daysOffset + 15) : null;

        final assignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: userId,
            courseVersionId: cvId,
            assignedById: assignerId,
            assignedAt: dt(daysOffset),
            dueDate: dt(daysOffset + 30),
            priority: ci < 3 ? 'high' : (ci < 6 ? 'medium' : 'low'),
            source: ci == 0 ? 'job_role' : 'manual',
            reason: 'Training matrix assignment',
          ),
        );

        final enrollment = await Enrollment.db.insertRow(
          session,
          Enrollment(
            userId: userId,
            courseVersionId: cvId,
            assignmentId: assignment.id!,
            status: isCompleted ? 'completed' : isInProgress ? 'in_progress' : 'not_started',
            startedAt: (isCompleted || isInProgress) ? dt(daysOffset + 1) : null,
            completedAt: completedAt,
          ),
        );
        enrollmentIds.add(enrollment.id!);
        assignmentCount++;

        if (isCompleted) {
          await AssessmentAttempt.db.insertRow(
            session,
            AssessmentAttempt(
              userId: userId,
              assessmentId: assessmentIds[ci],
              enrollmentId: enrollment.id!,
              startedAt: completedAt!.subtract(const Duration(minutes: 20)),
              completedAt: completedAt,
              score: 85 + (ui % 15),
            ),
          );

          final sigPayload = '$userId-cert-$cvId-${completedAt.toIso8601String()}';
          final hmac = Hmac(sha256, utf8.encode(hmacSecret));
          final integrityHash = hmac.convert(utf8.encode(sigPayload)).toString();

          final esig = await ElectronicSignature.db.insertRow(
            session,
            ElectronicSignature(
              userId: userId,
              signatureMeaning: meaningCompletion.meaning,
              entityType: 'Certificate',
              entityId: 'cert-$userId-$cvId',
              timestamp: completedAt,
              ipAddress: '10.0.${ui % 5}.${100 + (userId % 155)}',
              integrityHash: integrityHash,
            ),
          );

          final trainRec = await TrainingRecord.db.insertRow(
            session,
            TrainingRecord(
              userId: userId,
              courseVersionId: cvId,
              enrollmentId: enrollment.id!,
              esignatureId: esig.id!,
              completedAt: completedAt,
              score: 85 + (ui % 15),
            ),
          );

          final certHash = sha256.convert(utf8.encode('cert-$userId-$cvId-${completedAt.toIso8601String()}')).toString();
          await Certificate.db.insertRow(
            session,
            Certificate(
              userId: userId,
              courseVersionId: cvId,
              trainingRecordId: trainRec.id!,
              esignatureId: esig.id!,
              issuedAt: completedAt,
              expiresAt: completedAt.add(const Duration(days: 365)),
              qrCode: certHash,
              status: 'active',
            ),
          );
          certificateCount++;
        }
      }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 8b: DEMO EMPLOYEE — Rich data for testing ALL employee portal features
    // Login with "Employee" button → employee@pharmacorp.demo
    // ═══════════════════════════════════════════════════════════════════════════
    final demoEmployee = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals('employee@pharmacorp.demo'),
    );
    var demoCertCount = 0;
    if (demoEmployee != null) {
      final demoUid = demoEmployee.id!;
      final demoAssigner = trainerIds[0];

      // ── 1. COMPLETED courses (4) — shows in Training History, Certifications ──
      for (var ci = 0; ci < 4; ci++) {
        final cvId = courseVersionIds[ci];
        final completedDate = dt(-60 + ci * 10);

        final demoAssignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: demoUid,
            courseVersionId: cvId,
            assignedById: demoAssigner,
            assignedAt: dt(-120 + ci * 10),
            dueDate: dt(-30 + ci * 10),
            priority: 'high',
            source: 'job_role',
            reason: 'Mandatory GxP training',
          ),
        );
        final demoEnrollment = await Enrollment.db.insertRow(
          session,
          Enrollment(
            userId: demoUid,
            courseVersionId: cvId,
            assignmentId: demoAssignment.id!,
            status: 'completed',
            startedAt: dt(-100 + ci * 10),
            completedAt: completedDate,
          ),
        );
        enrollmentIds.add(demoEnrollment.id!);
        assignmentCount++;
        completedCount++;

        // Assessment attempt with passing score
        await AssessmentAttempt.db.insertRow(
          session,
          AssessmentAttempt(
            userId: demoUid,
            assessmentId: assessmentIds[ci],
            enrollmentId: demoEnrollment.id!,
            startedAt: completedDate.subtract(const Duration(minutes: 25)),
            completedAt: completedDate,
            score: 88 + ci * 3,
          ),
        );

        // E-signature + Certificate
        final sigPayload = '$demoUid-cert-$cvId-${completedDate.toIso8601String()}';
        final hmac = Hmac(sha256, utf8.encode(hmacSecret));
        final integrityHash = hmac.convert(utf8.encode(sigPayload)).toString();

        final esig = await ElectronicSignature.db.insertRow(
          session,
          ElectronicSignature(
            userId: demoUid,
            signatureMeaning: meaningCompletion.meaning,
            entityType: 'Certificate',
            entityId: 'cert-$demoUid-$cvId',
            timestamp: completedDate,
            ipAddress: '10.0.1.200',
            integrityHash: integrityHash,
          ),
        );

        final demoTrainRec = await TrainingRecord.db.insertRow(
          session,
          TrainingRecord(
            userId: demoUid,
            courseVersionId: cvId,
            enrollmentId: demoEnrollment.id!,
            esignatureId: esig.id!,
            completedAt: completedDate,
            score: 88 + ci * 3,
          ),
        );

        final certHash = sha256.convert(utf8.encode('cert-$demoUid-$cvId-${completedDate.toIso8601String()}')).toString();
        final expiresAt = ci == 0
            ? DateTime.now().add(const Duration(days: 25))
            : completedDate.add(const Duration(days: 365));
        await Certificate.db.insertRow(
          session,
          Certificate(
            userId: demoUid,
            courseVersionId: cvId,
            trainingRecordId: demoTrainRec.id!,
            esignatureId: esig.id!,
            issuedAt: completedDate,
            expiresAt: expiresAt,
            qrCode: certHash,
            status: 'active',
          ),
        );
        demoCertCount++;
        certificateCount++;
      }

      // ── 2. IN-PROGRESS courses (3) — shows on Dashboard "Continue Learning" ──
      for (var ci = 4; ci < 7; ci++) {
        final cvId = courseVersionIds[ci];
        final demoAssignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: demoUid,
            courseVersionId: cvId,
            assignedById: demoAssigner,
            assignedAt: dt(-30),
            dueDate: dt(14 + ci), // Due in ~2-3 weeks
            priority: ci == 4 ? 'high' : 'medium',
            source: 'manual',
            reason: 'Annual refresher training',
          ),
        );
        final demoEnrollment = await Enrollment.db.insertRow(
          session,
          Enrollment(
            userId: demoUid,
            courseVersionId: cvId,
            assignmentId: demoAssignment.id!,
            status: 'in_progress',
            startedAt: dt(-15),
          ),
        );
        enrollmentIds.add(demoEnrollment.id!);
        assignmentCount++;
      }

      // ── 3. NOT-STARTED / ASSIGNED courses (3) — shows in My Learning "To Do" ──
      for (var ci = 7; ci < 10; ci++) {
        final cvId = courseVersionIds[ci];
        final demoAssignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: demoUid,
            courseVersionId: cvId,
            assignedById: demoAssigner,
            assignedAt: dt(-5),
            dueDate: dt(25 + ci), // Due in ~1 month
            priority: 'low',
            source: 'manual',
            reason: 'New SOP revision training',
          ),
        );
        await Enrollment.db.insertRow(
          session,
          Enrollment(
            userId: demoUid,
            courseVersionId: cvId,
            assignmentId: demoAssignment.id!,
            status: 'not_started',
          ),
        );
        assignmentCount++;
      }

      // ── 4. OVERDUE courses (2) — triggers overdue alerts + notifications ──
      for (var ci = 10; ci < 12; ci++) {
        final cvId = courseVersionIds[ci];
        final demoAssignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: demoUid,
            courseVersionId: cvId,
            assignedById: demoAssigner,
            assignedAt: dt(-60),
            dueDate: dt(-5 - ci), // Already past due
            priority: 'high',
            source: 'job_role',
            reason: 'Compliance requirement — overdue',
          ),
        );
        await Enrollment.db.insertRow(
          session,
          Enrollment(
            userId: demoUid,
            courseVersionId: cvId,
            assignmentId: demoAssignment.id!,
            status: 'not_started',
          ),
        );
        assignmentCount++;
        overdueCount++;
      }

      // ── 5. Audit trail entries for demo employee ──
      final demoAuditActions = [
        ['LOGIN', 'User', 'login', -3],
        ['LESSON_OPENED', 'Lesson', 'lesson_opened', -3],
        ['LESSON_COMPLETED', 'Lesson', 'lesson_completed', -2],
        ['ASSESSMENT_STARTED', 'Assessment', 'assessment_started', -2],
        ['ASSESSMENT_SUBMITTED', 'Assessment', 'assessment_submitted', -2],
        ['CERTIFICATE_GENERATED', 'Certificate', 'certificate_generated', -2],
        ['LOGIN', 'User', 'login', -1],
        ['LESSON_OPENED', 'Lesson', 'lesson_opened', -1],
        ['LOGIN', 'User', 'login', 0],
      ];
      for (var ai = 0; ai < demoAuditActions.length; ai++) {
        final a = demoAuditActions[ai];
        final ts = dt(a[3] as int);
        final rowPayload = 'User-$demoUid-${a[0]}-${ts.toIso8601String()}';
        final hmac = Hmac(sha256, utf8.encode(hmacSecret));
        final rowHash = hmac.convert(utf8.encode(rowPayload)).toString();
        await AuditTrail.db.insertRow(
          session,
          AuditTrail(
            entityType: a[1] as String,
            entityId: 'demo-${ai + 1}',
            action: a[2] as String,
            timestamp: ts,
            userId: demoUid,
            ipAddress: '10.0.1.200',
            rowHash: rowHash,
          ),
        );
      }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 9: Audit Trail with Row Hashes
    // ═══════════════════════════════════════════════════════════════════════════
    final auditActions = ['LOGIN', 'LOGOUT', 'LESSON_OPENED', 'LESSON_COMPLETED',
      'ASSESSMENT_STARTED', 'ASSESSMENT_SUBMITTED', 'CERTIFICATE_GENERATED'];

    for (var i = 0; i < 100; i++) {
      final auditUserId = learnerIds[i % learnerIds.length];
      final action = auditActions[i % auditActions.length];
      final timestamp = dt(-30 + (i ~/ 10));
      final rowPayload = 'User-$auditUserId-$action-${timestamp.toIso8601String()}';
      final hmac = Hmac(sha256, utf8.encode(hmacSecret));
      final rowHash = hmac.convert(utf8.encode(rowPayload)).toString();

      await AuditTrail.db.insertRow(
        session,
        AuditTrail(
          entityType: action.contains('LESSON') ? 'Lesson' : 'User',
          entityId: 'entity-${(i + 1).toString().padLeft(4, '0')}',
          action: action.toLowerCase(),
          timestamp: timestamp,
          userId: auditUserId,
          ipAddress: '10.0.${(i % 5) + 1}.${100 + (i % 155)}',
          rowHash: rowHash,
        ),
      );
    }

    // Notifications
    for (var i = 0; i < overdueCount && i < enrollmentIds.length; i++) {
      await Notification.db.insertRow(
        session,
        Notification(
          userId: learnerIds[i % learnerIds.length],
          type: i % 3 == 0 ? 'overdue_employee' : 'reminder',
          enrollmentId: enrollmentIds[i],
          sentAt: dt(-7 + (i % 14)),
          deliveryStatus: 'delivered',
          channel: 'email',
        ),
      );
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 11: SOP Documents & Versions (for trainer SOP library + linkage)
    // ═══════════════════════════════════════════════════════════════════════════
    final sopConfigs = [
      ['GMP Manufacturing Procedures', 'SOP-GMP-001', 'sop', true],
      ['Cleaning Validation Protocol', 'SOP-CLN-002', 'sop', true],
      ['Equipment Calibration', 'SOP-CAL-003', 'sop', false],
      ['Environmental Monitoring', 'SOP-ENV-004', 'sop', true],
      ['Change Control Procedure', 'SOP-CHG-005', 'sop', true],
      ['Aseptic Processing Guidelines', 'SOP-ASEP-006', 'sop', true],
      ['CAPA Management', 'SOP-CAPA-007', 'sop', true],
      ['Data Integrity Policy', 'SOP-DI-008', 'policy', true],
      ['EHS Safety Manual', 'SOP-EHS-009', 'manual', false],
      ['Stability Study Protocol', 'SOP-STAB-010', 'sop', true],
      ['Audit Readiness Checklist', 'SOP-AUDIT-011', 'checklist', false],
      ['Employee Induction Guide', 'SOP-INDUCT-012', 'guide', false],
    ];

    for (var i = 0; i < sopConfigs.length; i++) {
      final s = sopConfigs[i];
      final doc = await Document.db.insertRow(
        session,
        Document(
          title: s[0] as String,
          documentNumber: s[1] as String,
          documentType: s[2] as String,
          organizationId: orgId,
          trainingRequiredByQa: (s[3] as bool) ? 'training_required' : 'no_training_required',
        ),
      );

      await DocumentVersion.db.insertRow(
        session,
        DocumentVersion(
          documentId: doc.id!,
          version: '1.0',
          storageKey: 's3://pharma-lms/docs/${s[1]}/v1.0.pdf',
          versionMajor: 1,
          versionMinor: 0,
          isMajorVersion: true,
          effectiveDate: dt(-180 + i * 5),
        ),
      );

      if (i < 4) {
        await DocumentVersion.db.insertRow(
          session,
          DocumentVersion(
            documentId: doc.id!,
            version: '2.0',
            storageKey: 's3://pharma-lms/docs/${s[1]}/v2.0.pdf',
            versionMajor: 2,
            versionMinor: 0,
            isMajorVersion: true,
            effectiveDate: dt(-30 + i * 3),
          ),
        );
      }
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 12: Draft & Under-Review Course Versions (for trainer workflows)
    // ═══════════════════════════════════════════════════════════════════════════
    final existingCourses = await Course.db.find(
      session,
      where: (t) => t.organizationId.equals(orgId),
    );

    final firstMaterial = await Material.db.findFirstRow(session);
    final defaultMaterialId = firstMaterial?.id ?? 1;

    var draftVersionCount = 0;
    for (var i = 0; i < existingCourses.length && i < 6; i++) {
      final course = existingCourses[i];
      final statuses = ['draft', 'under_review', 'draft', 'needs_revision', 'under_review', 'draft'];
      final ver = await CourseVersion.db.insertRow(
        session,
        CourseVersion(
          courseId: course.id!,
          version: '2.0',
          status: statuses[i],
        ),
      );

      final mod = await Module.db.insertRow(
        session,
        Module(
          courseVersionId: ver.id!,
          title: '${course.title} – Advanced Topics',
          orderIndex: 0,
        ),
      );

      await Lesson.db.insertRow(
        session,
        Lesson(
          moduleId: mod.id!,
          title: 'Advanced Concepts',
          materialId: defaultMaterialId,
          orderIndex: 0,
          durationMinutes: 45,
        ),
      );

      draftVersionCount++;
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 13: Training Records (for analytics/learner progress)
    // Uses completed enrollments + creates e-signatures for the records
    // ═══════════════════════════════════════════════════════════════════════════
    var trainingRecordCount = 0;
    for (var i = 0; i < enrollmentIds.length && i < completedCount; i++) {
      final learnerId = learnerIds[i % learnerIds.length];
      final cvId = courseVersionIds[i % courseVersionIds.length];
      final score = 70 + (i * 3 % 30);

      final esig = await ElectronicSignature.db.insertRow(
        session,
        ElectronicSignature(
          userId: learnerId,
          signatureMeaning: 'training_completion',
          entityType: 'enrollment',
          entityId: enrollmentIds[i].toString(),
        ),
      );

      await TrainingRecord.db.insertRow(
        session,
        TrainingRecord(
          userId: learnerId,
          courseVersionId: cvId,
          enrollmentId: enrollmentIds[i],
          esignatureId: esig.id!,
          completedAt: dt(-60 + i),
          score: score,
        ),
      );
      trainingRecordCount++;
    }

    // ═══ PHASE: Trainer Portal Seed Data ═══

    // 1. Course versions with pending_approval and needs_revision statuses
    final pendingApprovalVersions = await CourseVersion.db.find(
      session,
      where: (t) => t.status.equals('under_review'),
    );
    for (final v in pendingApprovalVersions) {
      await CourseVersion.db.updateRow(
        session,
        v.copyWith(status: 'pending_approval'),
      );
    }

    // 2. CourseReview records for QA history
    var courseReviewCount = 0;
    final effectiveVersions = await CourseVersion.db.find(
      session,
      where: (t) => t.status.equals('effective'),
      limit: 4,
    );
    if (effectiveVersions.length >= 4) {
      await CourseReview.db.insertRow(session, CourseReview(
        courseVersionId: effectiveVersions[0].id!,
        reviewerId: trainerIds[0],
        decision: 'approved',
        comments: 'Content meets GMP requirements. Assessment pool adequate.',
        reviewChecklistJson: '{"contentAccuracy":true,"regulatoryCompliance":true,"assessmentValidity":true}',
      ));
      courseReviewCount++;

      await CourseReview.db.insertRow(session, CourseReview(
        courseVersionId: effectiveVersions[1].id!,
        reviewerId: trainerIds[1],
        decision: 'approved',
        comments: 'Approved after revision. All issues addressed.',
      ));
      courseReviewCount++;

      await CourseReview.db.insertRow(session, CourseReview(
        courseVersionId: effectiveVersions[2].id!,
        reviewerId: trainerIds[2],
        decision: 'returned_for_changes',
        comments: 'Module 2 needs updated SOP references. Question pool insufficient.',
      ));
      courseReviewCount++;

      await CourseReview.db.insertRow(session, CourseReview(
        courseVersionId: effectiveVersions[3].id!,
        reviewerId: trainerIds[0],
        decision: 'rejected',
        comments: 'Does not meet 21 CFR Part 11 requirements. Major revision needed.',
      ));
      courseReviewCount++;
    }

    // 3. Trainer-specific audit events
    final allCourses = await Course.db.find(session, where: (t) => t.organizationId.equals(orgId));
    final allCourseIds = allCourses.map((c) => c.id!).toList();
    final trainerAuditActions = [
      'CourseCreated', 'CourseVersionCreated', 'ModuleCreated',
      'LessonCreated', 'MaterialUploaded', 'CourseSubmittedForQA',
      'DraftSaved', 'AssessmentCreated',
    ];
    for (var i = 0; i < trainerAuditActions.length; i++) {
      await AuditTrail.db.insertRow(session, AuditTrail(
        entityType: 'course',
        entityId: '${allCourseIds[i % allCourseIds.length]}',
        action: trainerAuditActions[i],
        timestamp: dt(-30 + i),
        userId: trainerIds[i % trainerIds.length],
        ipAddress: '10.0.1.${100 + i}',
      ));
    }

    // 4. Trainer in-app notifications
    for (var i = 0; i < 5; i++) {
      await Notification.db.insertRow(session, Notification(
        userId: trainerIds[i % trainerIds.length],
        type: i % 3 == 0 ? 'qa_approved' : i % 3 == 1 ? 'qa_returned' : 'sop_update',
        sentAt: dt(-i),
        deliveryStatus: 'delivered',
        channel: 'in_app',
      ));
    }

    // 5. Standalone question banks (not tied to courses)
    final standaloneBank1 = await QuestionBank.db.insertRow(session, QuestionBank(
      name: 'General GMP Knowledge Pool',
      organizationId: orgId,
      tagsJson: '["GMP","General","Cross-training"]',
    ));
    final standaloneBank2 = await QuestionBank.db.insertRow(session, QuestionBank(
      name: 'Regulatory Compliance Masters',
      organizationId: orgId,
      tagsJson: '["FDA","EMA","ICH","Regulatory"]',
    ));
    for (var i = 0; i < 15; i++) {
      await Question.db.insertRow(session, Question(
        questionBankId: i < 8 ? standaloneBank1.id! : standaloneBank2.id!,
        text: 'Standalone Q${i + 1}: ${i < 8 ? "GMP" : "Regulatory"} knowledge question',
        questionType: i % 2 == 0 ? 'multiple_choice' : 'true_false',
        optionsJson: i % 2 == 0 ? '["Option A","Option B","Option C","Option D"]' : '["True","False"]',
        correctAnswer: '0',
        difficulty: i % 3 == 0 ? 'easy' : i % 3 == 1 ? 'medium' : 'hard',
        regulatoryTag: i < 8 ? 'GMP' : 'FDA',
      ));
    }

    // 6. CourseSopLink records (explicit SOP-course links)
    var sopLinkCount = 0;
    final sopDocs = await Document.db.find(session, limit: 6);
    for (var i = 0; i < sopDocs.length && i < allCourseIds.length; i++) {
      await CourseSopLink.db.insertRow(session, CourseSopLink(
        courseId: allCourseIds[i],
        documentId: sopDocs[i].id!,
        linkedById: trainerIds[i % trainerIds.length],
      ));
      sopLinkCount++;
    }

    // 7. UserPreference records for demo trainer
    final demoTrainer = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals('trainer@pharmacorp.demo'),
    );
    if (demoTrainer != null) {
      await UserPreference.db.insertRow(session, UserPreference(
        userId: demoTrainer.id!,
        preferenceKey: 'email_notifications',
        preferenceValue: 'true',
      ));
      await UserPreference.db.insertRow(session, UserPreference(
        userId: demoTrainer.id!,
        preferenceKey: 'auto_save_drafts',
        preferenceValue: 'true',
      ));
      await UserPreference.db.insertRow(session, UserPreference(
        userId: demoTrainer.id!,
        preferenceKey: 'dark_mode',
        preferenceValue: 'false',
      ));
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 14: Training Batches (for batch management in Admin Portal)
    // ═══════════════════════════════════════════════════════════════════════════
    var trainingBatchCount = 0;
    final batchConfigs = [
      // [name, status, startOffset, endOffset, capacity, enrolledCount, completedCount, location]
      ['GMP Foundation - Q1 2026', 'completed', -90, -60, 25, 25, 25, 'Mumbai HQ - Training Room A'],
      ['Aseptic Technique - Q1 2026', 'completed', -75, -45, 20, 20, 18, 'Pune Manufacturing - Clean Room Training'],
      ['Data Integrity - March 2026', 'in_progress', -15, 30, 30, 28, 0, 'Hyderabad R&D - Conference Hall'],
      ['CAPA Training - April 2026', 'in_progress', -5, 40, 25, 22, 0, 'Mumbai HQ - Training Room B'],
      ['Quality Control Basics - Q2 2026', 'scheduled', 15, 45, 35, 18, 0, 'Bengaluru Biotech - Lab Training Center'],
      ['EHS Fundamentals - May 2026', 'scheduled', 30, 60, 40, 12, 0, 'Ahmedabad API - Safety Center'],
      ['Audit Readiness - June 2026', 'scheduled', 45, 75, 20, 5, 0, 'Mumbai HQ - Audit Room'],
      ['New Employee Induction - Rolling', 'in_progress', -10, 20, 50, 35, 15, 'All Sites - Virtual'],
    ];

    for (var i = 0; i < batchConfigs.length; i++) {
      final cfg = batchConfigs[i];
      final cvId = courseVersionIds[i % courseVersionIds.length];
      final instructorId = trainerIds[i % trainerIds.length];

      await TrainingBatch.db.insertRow(session, TrainingBatch(
        organizationId: orgId,
        courseVersionId: cvId,
        name: cfg[0] as String,
        instructorId: instructorId,
        startDate: dt(cfg[2] as int),
        endDate: dt(cfg[3] as int),
        capacity: cfg[4] as int,
        enrolledCount: cfg[5] as int,
        completedCount: cfg[6] as int,
        status: cfg[1] as String,
        location: cfg[7] as String,
        notes: 'Batch created via comprehensive seed.',
      ));
      trainingBatchCount++;
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 15: Notification Templates (for Admin Portal notifications management)
    // ═══════════════════════════════════════════════════════════════════════════
    var notificationTemplateCount = 0;
    final adminUser = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals('super.admin@pharmacorp.demo'),
    );
    final adminUserId = adminUser?.id;

    final templateConfigs = [
      // [name, type, channel, triggerEvent, subject, bodyTemplate, status]
      [
        'Training Assignment',
        'assignment',
        'email',
        'training_assigned',
        'New Training Assignment: {{courseTitle}}',
        'Dear {{userName}},\n\nYou have been assigned a new training: {{courseTitle}}.\n\nDue Date: {{dueDate}}\nPriority: {{priority}}\n\nPlease log in to the LMS to start your training.\n\nBest regards,\nTraining Team',
        'active',
      ],
      [
        'Due Date Reminder',
        'reminder',
        'email',
        'due_date_approaching',
        'Reminder: {{courseTitle}} Due in {{daysRemaining}} Days',
        'Dear {{userName}},\n\nThis is a reminder that your training "{{courseTitle}}" is due in {{daysRemaining}} days.\n\nDue Date: {{dueDate}}\n\nPlease complete your training to remain compliant.\n\nBest regards,\nTraining Team',
        'active',
      ],
      [
        'Overdue Alert',
        'overdue',
        'email',
        'training_overdue',
        'URGENT: Training Overdue - {{courseTitle}}',
        'Dear {{userName}},\n\nYour training "{{courseTitle}}" is now OVERDUE.\n\nOriginal Due Date: {{dueDate}}\nDays Overdue: {{daysOverdue}}\n\nPlease complete this training immediately to maintain compliance.\n\nBest regards,\nTraining Team',
        'active',
      ],
      [
        'Certificate Issued',
        'certificate',
        'email',
        'certificate_generated',
        'Congratulations! Certificate Issued for {{courseTitle}}',
        'Dear {{userName}},\n\nCongratulations on completing "{{courseTitle}}"!\n\nYour certificate has been issued and is available for download in the LMS.\n\nCertificate ID: {{certificateId}}\nIssued Date: {{issuedDate}}\nExpiry Date: {{expiryDate}}\n\nBest regards,\nTraining Team',
        'active',
      ],
      [
        'Certificate Expiring',
        'compliance',
        'email',
        'certificate_expiring',
        'Certificate Expiring: {{courseTitle}}',
        'Dear {{userName}},\n\nYour certificate for "{{courseTitle}}" will expire on {{expiryDate}}.\n\nPlease complete the refresher training to renew your certification.\n\nBest regards,\nTraining Team',
        'active',
      ],
      [
        'Push Assignment Alert',
        'assignment',
        'push',
        'training_assigned',
        null,
        'New training assigned: {{courseTitle}}. Due: {{dueDate}}',
        'active',
      ],
      [
        'Push Reminder',
        'reminder',
        'push',
        'due_date_approaching',
        null,
        '⏰ Reminder: {{courseTitle}} due in {{daysRemaining}} days',
        'active',
      ],
      [
        'SMS Overdue Alert',
        'overdue',
        'sms',
        'training_overdue',
        null,
        'URGENT: Training "{{courseTitle}}" is overdue. Please complete ASAP.',
        'active',
      ],
      [
        'In-App Welcome',
        'broadcast',
        'in_app',
        'user_created',
        'Welcome to PharmaTech LMS',
        'Welcome to PharmaTech LMS! Complete your profile setup and explore your assigned trainings.',
        'active',
      ],
      [
        'Monthly Newsletter Template',
        'broadcast',
        'email',
        'scheduled_monthly',
        'PharmaTech Training Newsletter - {{month}} {{year}}',
        'Dear {{userName}},\n\nHere is your monthly training update:\n\n• Completed: {{completedCount}} courses\n• In Progress: {{inProgressCount}} courses\n• Upcoming: {{upcomingCount}} courses\n\nKeep up the great work!\n\nBest regards,\nTraining Team',
        'draft',
      ],
      [
        'SOP Update Notification',
        'compliance',
        'email',
        'sop_updated',
        'SOP Update: {{sopNumber}} - Action Required',
        'Dear {{userName}},\n\nSOP {{sopNumber}} has been updated to version {{version}}.\n\nYou are required to complete the associated training by {{dueDate}}.\n\nPlease log in to the LMS to review the changes and complete your training.\n\nBest regards,\nQuality Assurance Team',
        'active',
      ],
      [
        'Batch Enrollment Confirmation',
        'assignment',
        'email',
        'batch_enrolled',
        'Enrollment Confirmed: {{batchName}}',
        'Dear {{userName}},\n\nYour enrollment in "{{batchName}}" has been confirmed.\n\nStart Date: {{startDate}}\nLocation: {{location}}\nInstructor: {{instructorName}}\n\nPlease ensure you are available for all scheduled sessions.\n\nBest regards,\nTraining Team',
        'active',
      ],
    ];

    for (final cfg in templateConfigs) {
      await NotificationTemplate.db.insertRow(session, NotificationTemplate(
        organizationId: orgId,
        name: cfg[0] as String,
        type: cfg[1] as String,
        channel: cfg[2] as String,
        triggerEvent: cfg[3],
        subject: cfg[4],
        bodyTemplate: cfg[5] as String,
        status: cfg[6] as String,
        createdById: adminUserId ?? trainerIds[0],
      ));
      notificationTemplateCount++;
    }

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 16: Additional Notifications for various users (Admin Portal display)
    // ═══════════════════════════════════════════════════════════════════════════
    // Add more diverse notifications for admin portal viewing
    final notificationTypes = ['assignment', 'reminder', 'overdue', 'certificate', 'compliance', 'broadcast'];
    final channels = ['email', 'push', 'sms', 'in_app'];
    final deliveryStatuses = ['delivered', 'pending', 'failed', 'read'];

    for (var i = 0; i < 30; i++) {
      final userId = learnerIds[i % learnerIds.length];
      final enrollId = i < enrollmentIds.length ? enrollmentIds[i] : null;
      final typeIdx = i % notificationTypes.length;
      final channelIdx = i % channels.length;
      final statusIdx = i % deliveryStatuses.length;
      final sentAt = dt(-30 + i);
      final readAt = statusIdx == 3 ? dt(-28 + i) : null;

      await Notification.db.insertRow(session, Notification(
        userId: userId,
        type: notificationTypes[typeIdx],
        enrollmentId: enrollId,
        sentAt: sentAt,
        deliveryStatus: deliveryStatuses[statusIdx],
        readAt: readAt,
        channel: channels[channelIdx],
      ));
    }

    var result = '''
COMPREHENSIVE SEED COMPLETED
═══════════════════════════════════════════════════════════════════════════════
Organization:  PharmaTech India Pvt Ltd
Sites:         5
Departments:   10
Job Roles:     14
Trainers:      15
Learners:      100
Courses:       12
Modules:       36
Lessons:       108
Assessments:   12
Training Matrix: 12 entries
Assignments:   $assignmentCount
Completed:     $completedCount
Overdue:       $overdueCount
Certificates:  $certificateCount
Audit Events:  100 (with HMAC row hashes)
SOP Documents: ${sopConfigs.length}
Draft Versions: $draftVersionCount
Training Recs: $trainingRecordCount
CourseReviews: $courseReviewCount
SOP Links: $sopLinkCount
Standalone Question Banks: 2 (23 questions)
Trainer Audit Events: ${trainerAuditActions.length}
Trainer Notifications: 5
UserPreferences: 3
Training Batches: $trainingBatchCount
Notification Templates: $notificationTemplateCount
Additional Notifications: 30

DEMO EMPLOYEE (employee@pharmacorp.demo):
  Completed:   4 courses (with certs + e-sigs + quiz scores)
  In Progress: 3 courses (due in 2-3 weeks)
  Not Started: 3 courses (assigned, due in 1 month)
  Overdue:     2 courses (triggers alerts)
  Certs:       $demoCertCount (1 expiring within 30 days)
  Audit Trail: 9 entries
═══════════════════════════════════════════════════════════════════════════════
''';

    // Provision Serverpod auth accounts so users can sign in with email/password.
    try {
      final authResult = await provisionAuthAccounts(session);
      result += '\n$authResult';
    } catch (e) {
      result += '\nAuth provisioning failed: $e';
    }

    return result;
  }

  /// Provisions Serverpod auth accounts for all PharmaUser records.
  /// Uses [_seedPassword] as the default password for all accounts.
  /// Skips users that already have an email auth account.
  Future<String> provisionAuthAccounts(Session session) async {
    final users = await PharmaUser.db.find(session);
    if (users.isEmpty) return 'No users found. Run seed first.';

    var created = 0;
    var skipped = 0;
    final emailIdp = AuthServices.instance.emailIdp;
    final admin = emailIdp.admin;

    for (final user in users) {
      if (user.id == null) continue;
      try {
        final existing = await admin.findAccount(session, email: user.email);
        if (existing != null) {
          skipped++;
          continue;
        }

        final authUser = await AuthServices.instance.authUsers.create(session);

        await admin.createEmailAuthentication(
          session,
          authUserId: authUser.id,
          email: user.email,
          password: _seedPassword,
        );

        // Also create a profile so _onAuthenticated can read email from it
        await session.db.unsafeQuery(
          r'''INSERT INTO serverpod_auth_core_profile ("authUserId", email, "userName", "fullName")
              VALUES (@authUserId::uuid, @email, @userName, @fullName)
              ON CONFLICT ("authUserId") DO NOTHING''',
          parameters: QueryParameters.named({
            'authUserId': authUser.id.toString(),
            'email': user.email,
            'userName': user.email.split('@').first,
            'fullName': '${user.firstName} ${user.lastName}',
          }),
        );

        created++;
      } catch (e) {
        session.log('Auth provision failed for ${user.email}: $e');
        skipped++;
      }
    }

    return 'Auth provisioned: $created created, $skipped skipped. Default password: $_seedPassword';
  }

  /// Helper method to delete all data related to an organization.
  /// Temporarily disables FK checks to avoid complex dependency ordering.
  Future<void> _deleteExistingOrgData(Session session, int orgId) async {
    await session.db.unsafeQuery("SET session_replication_role = 'replica'");

    try {
      final p = QueryParameters.named({'orgId': orgId});
      const u = 'SELECT id FROM pharma_user WHERE "organizationId" = @orgId';
      const c = 'SELECT id FROM course WHERE "organizationId" = @orgId';
      const cv = 'SELECT id FROM course_version WHERE "courseId" IN ($c)';
      const sit = 'SELECT id FROM site WHERE "organizationId" = @orgId';
      const dep = 'SELECT id FROM department WHERE "siteId" IN ($sit)';

      // Tables with "userId" column
      for (final t in [
        'access_log', 'audit_trail', 'assessment_attempt', 'certificate',
        'electronic_signature', 'enrollment', 'material_progress',
        'notification', 'training_assignment', 'training_record',
        'training_waiver', 'user_competency', 'user_preference',
        'user_role', 'user_session',
      ]) {
        await session.db.unsafeQuery('DELETE FROM $t WHERE "userId" IN ($u)', parameters: p);
      }

      // Tables referencing users via other column names
      await session.db.unsafeQuery('DELETE FROM approval_workflow WHERE "approverId" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM auditor_session WHERE "auditorUserId" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM course_review WHERE "reviewerId" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM course_sop_link WHERE "linkedById" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM delegated_authority WHERE "delegatorId" IN ($u) OR "delegateeId" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM import_log WHERE "importedById" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM inspection_package WHERE "generatedById" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM inspection_record WHERE "createdById" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM report_export WHERE "exportedById" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM training_record_annotation WHERE "authorId" IN ($u)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM document_lifecycle WHERE "changedById" IN ($u)', parameters: p);

      // Grandchild tables
      await session.db.unsafeQuery('DELETE FROM notification_log WHERE "notificationId" IN (SELECT id FROM notification WHERE "userId" IN ($u))', parameters: p);
      await session.db.unsafeQuery('DELETE FROM assessment_result WHERE "attemptId" IN (SELECT id FROM assessment_attempt WHERE "userId" IN ($u))', parameters: p);
      await session.db.unsafeQuery('DELETE FROM training_expiration WHERE "certificateId" IN (SELECT id FROM certificate WHERE "userId" IN ($u))', parameters: p);
      await session.db.unsafeQuery('DELETE FROM capa WHERE "trainingAssignmentId" IN (SELECT id FROM training_assignment WHERE "userId" IN ($u))', parameters: p);

      // Users
      await session.db.unsafeQuery('DELETE FROM pharma_user WHERE "organizationId" = @orgId', parameters: p);

      // Documents
      await session.db.unsafeQuery('DELETE FROM change_control WHERE "documentVersionId" IN (SELECT id FROM document_version WHERE "documentId" IN (SELECT id FROM document WHERE "organizationId" = @orgId))', parameters: p);
      await session.db.unsafeQuery('DELETE FROM document_version WHERE "documentId" IN (SELECT id FROM document WHERE "organizationId" = @orgId)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM document WHERE "organizationId" = @orgId', parameters: p);

      // Course content
      await session.db.unsafeQuery('DELETE FROM lesson WHERE "moduleId" IN (SELECT id FROM module WHERE "courseVersionId" IN ($cv))', parameters: p);
      await session.db.unsafeQuery('DELETE FROM module WHERE "courseVersionId" IN ($cv)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM question WHERE "questionBankId" IN (SELECT "questionBankId" FROM assessment WHERE "courseVersionId" IN ($cv))', parameters: p);
      await session.db.unsafeQuery('DELETE FROM assessment WHERE "courseVersionId" IN ($cv)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM course_version WHERE "courseId" IN ($c)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM course_competency WHERE "courseId" IN ($c)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM training_matrix WHERE "courseId" IN ($c)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM course WHERE "organizationId" = @orgId', parameters: p);

      // Org structure
      await session.db.unsafeQuery('DELETE FROM department_compliance_snapshot WHERE "departmentId" IN ($dep)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM job_role WHERE "departmentId" IN ($dep)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM department WHERE "siteId" IN ($sit)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM quality_event WHERE "siteId" IN ($sit)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM inspection_report WHERE "organizationId" = @orgId', parameters: p);
      await session.db.unsafeQuery('DELETE FROM site WHERE "organizationId" = @orgId', parameters: p);

      // Materials
      await session.db.unsafeQuery('DELETE FROM material_version WHERE "materialId" IN (SELECT id FROM material WHERE "organizationId" = @orgId)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM material WHERE "organizationId" = @orgId', parameters: p);

      // Question banks
      await session.db.unsafeQuery('DELETE FROM question WHERE "questionBankId" IN (SELECT id FROM question_bank WHERE "organizationId" = @orgId)', parameters: p);
      await session.db.unsafeQuery('DELETE FROM question_bank WHERE "organizationId" = @orgId', parameters: p);

      // Misc org-level tables
      await session.db.unsafeQuery('DELETE FROM feature_flag WHERE "organizationId" = @orgId', parameters: p);
      await session.db.unsafeQuery('DELETE FROM system_configuration WHERE "organizationId" = @orgId', parameters: p);
      
      // Training batches
      await session.db.unsafeQuery('DELETE FROM training_batch WHERE "organizationId" = @orgId', parameters: p);
      
      // Notification templates
      await session.db.unsafeQuery('DELETE FROM notification_template WHERE "organizationId" = @orgId', parameters: p);

      // Organization itself
      await session.db.unsafeQuery('DELETE FROM organization WHERE id = @orgId', parameters: p);
    } finally {
      await session.db.unsafeQuery("SET session_replication_role = 'origin'");
    }
  }

  /// Fix admin passwords by re-provisioning them with proper password hashes
  Future<String> fixAdminPasswords(Session session) async {
    final adminEmails = [
      'super.admin@pharmacorp.demo',
      'content.admin@pharmacorp.demo',
      'qa.manager@pharmacorp.demo',
      'training.admin@pharmacorp.demo',
      'audit.officer@pharmacorp.demo',
    ];

    var fixed = 0;
    var failed = 0;
    final emailIdp = AuthServices.instance.emailIdp;
    final admin = emailIdp.admin;

    for (final email in adminEmails) {
      try {
        // Check if account exists
        final existing = await admin.findAccount(session, email: email);
        
        if (existing == null) {
          // Create new account if it doesn't exist
          final authUser = await AuthServices.instance.authUsers.create(session);
          await admin.createEmailAuthentication(
            session,
            authUserId: authUser.id,
            email: email,
            password: _seedPassword,
          );
          session.log('Created new auth account for $email');

          // Create profile
          await session.db.unsafeQuery(
            r'''INSERT INTO serverpod_auth_core_profile ("authUserId", email, "userName", "fullName")
                VALUES (@authUserId::uuid, @email, @userName, @fullName)
                ON CONFLICT ("authUserId") DO NOTHING''',
            parameters: QueryParameters.named({
              'authUserId': authUser.id.toString(),
              'email': email,
              'userName': email.split('@').first,
              'fullName': _getFullName(email),
            }),
          );
        } else {
          // Account exists - update password by directly deleting old email auth and recreating
          try {
            // Try direct SQL delete of old email authentication
            await session.db.unsafeQuery(
              r'''DELETE FROM serverpod_auth_core_email_auth 
                  WHERE "authUserId" = @authUserId::uuid''',
              parameters: QueryParameters.named({
                'authUserId': existing.id!.toString(),
              }),
            );
            session.log('Deleted old email auth for $email');
          } catch (e) {
            session.log('Could not delete old email auth: $e');
          }

          // Now recreate email authentication with new password
          try {
            await admin.createEmailAuthentication(
              session,
              authUserId: existing.id!,
              email: email,
              password: _seedPassword,
            );
            session.log('Updated password for $email');
          } catch (e) {
            session.log('Could not create new email auth: $e');
          }
        }

        fixed++;
        session.log('✓ Password fixed for $email');
      } catch (e) {
        failed++;
        session.log('✗ Failed to fix password for $email: $e');
      }
    }

    return 'Fixed admin passwords: $fixed fixed, $failed failed. Password: $_seedPassword';
  }

  String _getFullName(String email) {
    const names = {
      'super.admin@pharmacorp.demo': 'Super Administrator',
      'content.admin@pharmacorp.demo': 'Content Administrator',
      'qa.manager@pharmacorp.demo': 'Quality Manager',
      'training.admin@pharmacorp.demo': 'Training Administrator',
      'audit.officer@pharmacorp.demo': 'Audit Officer',
    };
    return names[email] ?? email.split('@').first;
  }
}
