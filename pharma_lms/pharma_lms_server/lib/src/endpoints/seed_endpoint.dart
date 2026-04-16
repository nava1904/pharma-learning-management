import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import '../seeding/cleanup/organization_cleanup.dart';
import '../seeding/seed_context.dart';
import '../seeding/tables/access_session_seed.dart';
import '../seeding/tables/analytics_seed.dart';
import '../seeding/tables/department_seed.dart';
import '../seeding/tables/infrastructure_seed.dart';
import '../seeding/tables/material_progress_seed.dart';
import '../seeding/tables/organization_seed.dart';
import '../seeding/tables/qa_users_seed.dart';
import '../seeding/tables/quality_seed.dart';
import '../seeding/tables/site_seed.dart';
import '../seeding/tables/training_batch_seed.dart';

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
    final messages = <String>[];

    final existingOrg = await Organization.db.findFirstRow(
      session,
      where: (t) => t.name.equals('PharmaTech India Pvt Ltd'),
    );

    if (existingOrg != null) {
      await OrganizationCleanup.deleteExistingOrgData(session, existingOrg.id!);
      messages.add('Deleted organization and all related data: PharmaTech India Pvt Ltd');
    } else {
      messages.add('No existing PharmaTech India organization found');
    }

    final seedResult = await runComprehensiveSeed(session);
    messages.add(seedResult);

    return messages.join('\n');
  }

  /// Comprehensive seed with 100 learners, 10 trainers, 5 admin, 5 QA,
  /// 12 pharma courses, analytics snapshots, quality events, ILT batches,
  /// material progress, certificates, e-signatures, competencies, and more.
  Future<String> runComprehensiveSeed(Session session) async {
    try {
      return await _runComprehensiveSeed(session);
    } catch (e, st) {
      session.log('runComprehensiveSeed failed: $e\n$st');
      return 'SEED FAILED: $e\n\nStack trace:\n$st';
    }
  }

  Future<String> _runComprehensiveSeed(Session session) async {
    final baseDate = DateTime(2026, 3, 14);
    DateTime dt(int offsetDays) => baseDate.add(Duration(days: offsetDays));

    // First delete existing data if organization exists
    final existing = await Organization.db.findFirstRow(
      session,
      where: (t) => t.name.equals('PharmaTech India Pvt Ltd'),
    );
    if (existing != null) {
      await OrganizationCleanup.deleteExistingOrgData(session, existing.id!);
    }

    // HMAC secret for integrity hashes (FR-02-02 AC-06)
    const hmacSecret = 'pharma-lms-super-secret-audit-key-2026';

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 1: Organization, Sites, Departments
    // ═══════════════════════════════════════════════════════════════════════
    final org = await OrganizationSeed.insert(session);
    final orgId = org.id!;
    final siteIds = await SiteSeed.insertForOrganization(session, orgId);
    final deptIds = await DepartmentSeed.insertForDefaultSite(session, siteIds[0]);

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 2: Roles & Permissions
    // ═══════════════════════════════════════════════════════════════════════
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

    // Permissions
    final permissionData = <List<String>>[
      ['admin', '*', '*'],
      ['qa_director', '*', 'read'], ['qa_director', 'quality_event', 'write'],
      ['qa_director', 'compliance', 'write'], ['qa_director', 'course', 'write'],
      ['qa_manager', '*', 'read'], ['qa_manager', 'quality_event', 'write'],
      ['qa_manager', 'compliance', 'write'], ['qa_manager', 'course', 'write'],
      ['trainer', 'course', 'read'], ['trainer', 'course', 'write'],
      ['trainer', 'material', 'read'], ['trainer', 'material', 'write'],
      ['trainer', 'assessment', 'read'], ['trainer', 'assessment', 'write'],
      ['trainer', 'training', 'read'], ['trainer', 'training', 'write'],
      ['trainer', 'training', 'assign'], ['trainer', 'analytics', 'read'],
      ['trainer', 'analytics', 'write'], ['trainer', 'audit', 'read'],
      ['trainer', 'organization', 'read'], ['trainer', 'compliance', 'read'],
      ['trainer', 'quality_event', 'read'], ['trainer', 'document', 'read'],
      ['trainer', 'document', 'write'],
      ['sme', 'course', 'read'], ['sme', 'course', 'write'],
      ['sme', 'material', 'read'], ['sme', 'material', 'write'],
      ['sme', 'assessment', 'read'], ['sme', 'assessment', 'write'],
      ['sme', 'training', 'read'], ['sme', 'training', 'write'],
      ['sme', 'training', 'assign'], ['sme', 'analytics', 'read'],
      ['sme', 'audit', 'read'], ['sme', 'organization', 'read'],
      ['sme', 'compliance', 'read'], ['sme', 'document', 'read'],
      ['sme', 'document', 'write'],
      ['employee', 'training', 'read'], ['employee', 'compliance', 'read'],
      ['employee', 'analytics', 'read'], ['employee', 'organization', 'read'],
      ['employee', 'course', 'read'], ['employee', 'material', 'read'],
      ['employee', 'assessment', 'read'],
      ['auditor', '*', 'read'], ['auditor', 'audit', 'read'],
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 3: Job Roles
    // ═══════════════════════════════════════════════════════════════════════
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 3b: Signature Meanings (FR-02-01)
    // ═══════════════════════════════════════════════════════════════════════
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 4: Trainers (10)
    // ═══════════════════════════════════════════════════════════════════════
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 5: Learners (100)
    // ═══════════════════════════════════════════════════════════════════════
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 5b: Admin Users (5)
    // ═══════════════════════════════════════════════════════════════════════
    final adminUsers = <List<dynamic>>[
      ['super.admin@pharmacorp.demo', 'Super', 'Administrator', 'ADM-001', 0, 0, 'admin'],
      ['content.admin@pharmacorp.demo', 'Content', 'Administrator', 'ADM-002', 0, 7, 'admin'],
      ['qa.manager@pharmacorp.demo', 'Quality', 'Manager', 'ADM-003', 1, 0, 'qa_manager'],
      ['training.admin@pharmacorp.demo', 'Training', 'Administrator', 'ADM-004', 2, 7, 'admin'],
      ['audit.officer@pharmacorp.demo', 'Audit', 'Officer', 'ADM-005', 4, 3, 'auditor'],
    ];
    final adminUserIds = <int>[];
    for (final a in adminUsers) {
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
            jobRoleId: jobRoleIds[0],
            organizationId: orgId,
            status: 'active',
            hireDate: dt(-730),
          ),
        );
        adminUserIds.add(adminUser.id!);
        await UserRole.db.insertRow(
          session,
          UserRole(userId: adminUser.id!, roleId: roleIds[a[6] as String]!),
        );
      }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 5c: Demo Users (for development/testing login flow)
    // ═══════════════════════════════════════════════════════════════════════
    final demoUsers = [
      ['employee@pharmacorp.demo', 'Demo', 'Employee', 'DEMO-EMP', 'employee'],
      ['admin@pharmacorp.demo', 'Demo', 'Admin', 'DEMO-ADM', 'admin'],
      ['qa@pharmacorp.demo', 'Demo', 'QA', 'DEMO-QA', 'qa_manager'],
      ['trainer@pharmacorp.demo', 'Demo', 'Trainer', 'DEMO-TRN', 'trainer'],
      ['auditor@pharmacorp.demo', 'Demo', 'Auditor', 'DEMO-AUD', 'auditor'],
      ['analytics@pharmacorp.demo', 'Demo', 'Analytics', 'DEMO-ANA', 'admin'],
    ];
    for (final d in demoUsers) {
      final existingDemo = await PharmaUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(d[0]),
      );
      if (existingDemo == null) {
        final demoUser = await PharmaUser.db.insertRow(
          session,
          PharmaUser(
            email: d[0],
            firstName: d[1],
            lastName: d[2],
            employeeId: d[3],
            siteId: siteIds[0],
            departmentId: deptIds[0],
            jobRoleId: jobRoleIds[0],
            organizationId: orgId,
            status: 'active',
            hireDate: dt(-365),
          ),
        );
        await UserRole.db.insertRow(
          session,
          UserRole(userId: demoUser.id!, roleId: roleIds[d[4]]!),
        );
      }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 5d: QA Users (5) — dedicated quality assurance users
    // ═══════════════════════════════════════════════════════════════════════
    // Build a partial context for QA seed (needs orgId, siteIds, deptIds, jobRoleIds, roleIds)
    final partialCtx = SeedContext(
      orgId: orgId,
      siteIds: siteIds,
      deptIds: deptIds,
      jobRoleIds: jobRoleIds,
      roleIds: roleIds,
      trainerIds: trainerIds,
      learnerIds: learnerIds,
      qaUserIds: [], // will be filled after
      adminUserIds: adminUserIds,
      courseVersionIds: [],
      courseIds: [],
      assessmentIds: [],
      enrollmentIds: [],
      materialIds: [],
      questionBankIds: [],
      documentIds: [],
      documentVersionIds: [],
      baseDate: baseDate,
      hmacSecret: hmacSecret,
      completionMeaning: meaningCompletion.meaning,
    );
    final qaUserIds = await QaUsersSeed.insert(session, partialCtx);

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 6: Courses (12) with modules, lessons, assessments, materials
    // ═══════════════════════════════════════════════════════════════════════
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
    final catalogMetaByIndex = <int, String>{
      0: jsonEncode({'department': 'Quality', 'difficulty': 'beginner', 'creditHours': 4, 'estimatedMinutes': 240, 'isMandatory': true, 'imageUrl': 'https://images.unsplash.com/photo-1582719471137-c3967ffb841b?w=800&q=80'}),
      1: jsonEncode({'department': 'Quality', 'difficulty': 'intermediate', 'creditHours': 6, 'estimatedMinutes': 360, 'isMandatory': true, 'imageUrl': 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&q=80'}),
      2: jsonEncode({'department': 'Clinical', 'difficulty': 'intermediate', 'creditHours': 6, 'estimatedMinutes': 300, 'isMandatory': true, 'imageUrl': 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&q=80'}),
      3: jsonEncode({'department': 'R&D', 'difficulty': 'advanced', 'creditHours': 3, 'estimatedMinutes': 180, 'isMandatory': false, 'imageUrl': 'https://images.unsplash.com/photo-1532187863486-abf9db0301d0?w=800&q=80'}),
      4: jsonEncode({'department': 'Manufacturing', 'difficulty': 'intermediate', 'creditHours': 5, 'estimatedMinutes': 200, 'isMandatory': false, 'imageUrl': 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=800&q=80'}),
      5: jsonEncode({'department': 'Manufacturing', 'difficulty': 'advanced', 'creditHours': 8, 'estimatedMinutes': 480, 'isMandatory': true, 'imageUrl': 'https://images.unsplash.com/photo-1579684385127-1ef15d5081ce?w=800&q=80'}),
      6: jsonEncode({'department': 'Quality', 'difficulty': 'intermediate', 'creditHours': 4, 'estimatedMinutes': 220, 'isMandatory': true, 'imageUrl': 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?w=800&q=80'}),
      7: jsonEncode({'department': 'Quality', 'difficulty': 'beginner', 'creditHours': 3, 'estimatedMinutes': 120, 'isMandatory': true, 'imageUrl': 'https://images.unsplash.com/photo-1556761175-5973dc0f64e7?w=800&q=80'}),
      8: jsonEncode({'department': 'EHS', 'difficulty': 'beginner', 'creditHours': 2, 'estimatedMinutes': 90, 'isMandatory': false, 'imageUrl': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800&q=80'}),
      9: jsonEncode({'department': 'R&D', 'difficulty': 'advanced', 'creditHours': 12, 'estimatedMinutes': 600, 'isMandatory': false, 'imageUrl': 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800&q=80'}),
      10: jsonEncode({'department': 'Regulatory', 'difficulty': 'intermediate', 'creditHours': 4, 'estimatedMinutes': 240, 'isMandatory': true, 'imageUrl': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800&q=80'}),
      11: jsonEncode({'department': 'Quality', 'difficulty': 'beginner', 'creditHours': 2, 'estimatedMinutes': 60, 'isMandatory': true, 'imageUrl': 'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=800&q=80'}),
    };

    final courseVersionIds = <int>[];
    final courseIds = <int>[];
    final assessmentIds = <int>[];
    final materialIds = <int>[];
    final questionBankIds = <int>[];

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
          customMetadataJson: catalogMetaByIndex[i],
        ),
      );
      courseIds.add(course.id!);

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
      questionBankIds.add(qb.id!);

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

      // Modules & Lessons with Materials
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
          materialIds.add(mat.id!);
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 7: Enrollments, Certificates, E-signatures
    // ═══════════════════════════════════════════════════════════════════════
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
            status: isCompleted ? 'completed' : isInProgress ? 'in progress' : 'not started',
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 7b: DEMO EMPLOYEE — Rich data for testing ALL employee portal
    // ═══════════════════════════════════════════════════════════════════════
    final demoEmployee = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals('employee@pharmacorp.demo'),
    );
    var demoCertCount = 0;
    if (demoEmployee != null) {
      final demoUid = demoEmployee.id!;
      final demoAssigner = trainerIds[0];

      // Completed courses (4)
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

      // In-progress courses (3)
      for (var ci = 4; ci < 7; ci++) {
        final cvId = courseVersionIds[ci];
        final demoAssignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: demoUid,
            courseVersionId: cvId,
            assignedById: demoAssigner,
            assignedAt: dt(-30),
            dueDate: dt(14 + ci),
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

      // Not-started courses (3)
      for (var ci = 7; ci < 10; ci++) {
        final cvId = courseVersionIds[ci];
        final demoAssignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: demoUid,
            courseVersionId: cvId,
            assignedById: demoAssigner,
            assignedAt: dt(-5),
            dueDate: dt(25 + ci),
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

      // Overdue courses (2)
      for (var ci = 10; ci < 12; ci++) {
        final cvId = courseVersionIds[ci];
        final demoAssignment = await TrainingAssignment.db.insertRow(
          session,
          TrainingAssignment(
            userId: demoUid,
            courseVersionId: cvId,
            assignedById: demoAssigner,
            assignedAt: dt(-60),
            dueDate: dt(-5 - ci),
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

      // Demo employee audit trail
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

      // ILT batch for demo employee
      final iltCvId = courseVersionIds[4];
      final iltBatch = await TrainingBatch.db.insertRow(
        session,
        TrainingBatch(
          organizationId: orgId,
          courseVersionId: iltCvId,
          name: 'QA Intake cohort (ILT demo)',
          instructorId: trainerIds[0],
          startDate: dt(-7),
          endDate: dt(30),
          capacity: 40,
          enrolledCount: 0,
          completedCount: 0,
          status: 'in progress',
          location: 'Mumbai HQ — Training Room A',
          notes: 'SOP updates: see document control.\nWeekly cohort sync: Fridays 10:00 IST.',
        ),
      );
      final rosterEntries = <(int uid, String?)>[
        (demoUid, null),
        (learnerIds[0], null),
        (learnerIds[1], null),
        (learnerIds[2], null),
        (learnerIds[3], null),
        (learnerIds[4], null),
        (trainerIds[1], 'mentor'),
      ];
      for (final r in rosterEntries) {
        await TrainingBatchParticipant.db.insertRow(
          session,
          TrainingBatchParticipant(batchId: iltBatch.id!, userId: r.$1, role: r.$2),
        );
      }
      await TrainingBatch.db.updateRow(
        session,
        iltBatch.copyWith(enrolledCount: rosterEntries.length),
      );
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 8: Audit Trail with Row Hashes
    // ═══════════════════════════════════════════════════════════════════════
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 9: SOP Documents & Versions
    // ═══════════════════════════════════════════════════════════════════════
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

    final documentIds = <int>[];
    final documentVersionIds = <int>[];
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
      documentIds.add(doc.id!);

      final dv = await DocumentVersion.db.insertRow(
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
      documentVersionIds.add(dv.id!);

      if (i < 4) {
        final dv2 = await DocumentVersion.db.insertRow(
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
        documentVersionIds.add(dv2.id!);
      }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 10: Draft & Under-Review Course Versions
    // ═══════════════════════════════════════════════════════════════════════
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 11: Training Records (for analytics/learner progress)
    // ═══════════════════════════════════════════════════════════════════════
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

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 12: Trainer Portal Data
    // ═══════════════════════════════════════════════════════════════════════
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

    // CourseReview records
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
      await CourseReview.db.insertRow(session, CourseReview(
        courseVersionId: effectiveVersions[1].id!,
        reviewerId: trainerIds[1],
        decision: 'approved',
        comments: 'Approved after revision. All issues addressed.',
      ));
      await CourseReview.db.insertRow(session, CourseReview(
        courseVersionId: effectiveVersions[2].id!,
        reviewerId: trainerIds[2],
        decision: 'returned_for_changes',
        comments: 'Module 2 needs updated SOP references. Question pool insufficient.',
      ));
      await CourseReview.db.insertRow(session, CourseReview(
        courseVersionId: effectiveVersions[3].id!,
        reviewerId: trainerIds[0],
        decision: 'rejected',
        comments: 'Does not meet 21 CFR Part 11 requirements. Major revision needed.',
      ));
      courseReviewCount = 4;
    }

    // Trainer audit events
    final allCourses = await Course.db.find(session, where: (t) => t.organizationId.equals(orgId));
    final allCourseIds = allCourses.map((c) => c.id!).toList();
    final trainerAuditActions = [
      'CourseCreated', 'CourseVersionCreated', 'ModuleCreated',
      'LessonCreated', 'MaterialUploaded', 'CourseSubmittedForQA',
      'DraftSaved', 'AssessmentCreated',
    ];
    if (allCourseIds.isNotEmpty) {
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
    }

    // Demo trainer audit
    final demoTrainerUser = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals('trainer@pharmacorp.demo'),
    );
    if (demoTrainerUser?.id != null && allCourseIds.isNotEmpty) {
      final demoTrainerAudit = ['CourseCreated', 'LessonCreated', 'MaterialUploaded', 'CourseSubmittedForQA', 'DraftSaved'];
      for (var i = 0; i < demoTrainerAudit.length; i++) {
        await AuditTrail.db.insertRow(session, AuditTrail(
          entityType: 'course',
          entityId: '${allCourseIds[i % allCourseIds.length]}',
          action: demoTrainerAudit[i],
          timestamp: dt(-14 + i),
          userId: demoTrainerUser!.id!,
          ipAddress: '10.0.1.${180 + i}',
        ));
      }
    }

    // Trainer notifications
    for (var i = 0; i < 5; i++) {
      await Notification.db.insertRow(session, Notification(
        userId: trainerIds[i % trainerIds.length],
        type: i % 3 == 0 ? 'qa_approved' : i % 3 == 1 ? 'qa_returned' : 'sop_update',
        sentAt: dt(-i),
        deliveryStatus: 'delivered',
        channel: 'in_app',
      ));
    }

    // Standalone question banks
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

    // CourseSopLink
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

    // Demo trainer preferences
    final demoTrainer = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals('trainer@pharmacorp.demo'),
    );
    if (demoTrainer != null) {
      for (final pref in [
        ('email_notifications', 'true'),
        ('auto_save_drafts', 'true'),
        ('dark_mode', 'false'),
      ]) {
        await UserPreference.db.insertRow(session, UserPreference(
          userId: demoTrainer.id!,
          preferenceKey: pref.$1,
          preferenceValue: pref.$2,
        ));
      }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PHASE 13: NEW — Modular seed phases (analytics, quality, batches, etc.)
    // ═══════════════════════════════════════════════════════════════════════
    final ctx = SeedContext(
      orgId: orgId,
      siteIds: siteIds,
      deptIds: deptIds,
      jobRoleIds: jobRoleIds,
      roleIds: roleIds,
      trainerIds: trainerIds,
      learnerIds: learnerIds,
      qaUserIds: qaUserIds,
      adminUserIds: adminUserIds,
      courseVersionIds: courseVersionIds,
      courseIds: courseIds,
      assessmentIds: assessmentIds,
      enrollmentIds: enrollmentIds,
      materialIds: materialIds,
      questionBankIds: questionBankIds,
      documentIds: documentIds,
      documentVersionIds: documentVersionIds,
      baseDate: baseDate,
      hmacSecret: hmacSecret,
      completionMeaning: meaningCompletion.meaning,
    );

    // Analytics snapshots (6 months of org + department trending)
    await AnalyticsSeed.insertAnalyticsSnapshots(session, ctx);
    await AnalyticsSeed.insertDeptComplianceSnapshots(session, ctx);

    // Quality events, CAPAs, inspections
    await QualitySeed.insert(session, ctx);

    // Training batches with participants, live classes, attendance
    await TrainingBatchSeed.insert(session, ctx);

    // Material progress for learners
    final materialProgressCount = await MaterialProgressSeed.insert(session, ctx);

    // Infrastructure: facilities, cert templates, competencies, notifications, config
    await InfrastructureSeed.insertFacilities(session, ctx);
    await InfrastructureSeed.insertCertificateTemplates(session, ctx);
    await InfrastructureSeed.insertCompetencies(session, ctx);
    await InfrastructureSeed.insertNotificationTemplates(session, ctx);
    await InfrastructureSeed.insertSystemConfiguration(session, ctx);
    await InfrastructureSeed.insertFeatureFlags(session, ctx);
    await InfrastructureSeed.insertScheduledJobLogs(session, ctx);
    await InfrastructureSeed.insertRetentionPolicies(session);

    // Access logs, user sessions, standalone assignments, waivers, SME, messages
    await AccessSessionSeed.insertAccessLogs(session, ctx);
    await AccessSessionSeed.insertUserSessions(session, ctx);
    await AccessSessionSeed.insertStandaloneAssignments(session, ctx);
    await AccessSessionSeed.insertTrainingWaivers(session, ctx);
    await AccessSessionSeed.insertSmeData(session, ctx);
    await AccessSessionSeed.insertMessages(session, ctx);

    // ═══════════════════════════════════════════════════════════════════════
    // SUMMARY
    // ═══════════════════════════════════════════════════════════════════════
    var result = '''
COMPREHENSIVE SEED COMPLETED
═══════════════════════════════════════════════════════════════════════════════
Organization:  PharmaTech India Pvt Ltd
Sites:         5
Departments:   10
Job Roles:     14
Trainers:      10
Learners:      100
QA Users:      5
Admin Users:   ${adminUserIds.length}
Demo Users:    6
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
SOP Links:     $sopLinkCount
Standalone Q Banks: 2 (23 questions)
Material Progress: $materialProgressCount
Analytics Snapshots: 6 (monthly)
Dept Compliance Snapshots: 60 (10 depts × 6 months)
Quality Events: 10 (deviations + CAPAs + change controls)
CAPAs:         4
Inspections:   5
Inspection Reports: 2
Training Batches: 5 (with participants, live classes, attendance)
Facilities:    6
Cert Templates: 2
Competencies:  8
User Competencies: 40
Notification Templates: 6
System Config: 15 entries
Feature Flags: 8
Scheduled Jobs: 8
Retention Policies: 6
Access Logs:   ~100 (login/logout)
User Sessions: ~35
Standalone Assignments: 4 (with recipients)
Training Waivers: 4
SME Assignments: 3 (with review comments)
Learner-Trainer Messages: 10+

DEMO EMPLOYEE (employee@pharmacorp.demo):
  Completed:   4 courses (with certs + e-sigs + quiz scores)
  In Progress: 3 courses (due in 2-3 weeks)
  Not Started: 3 courses (assigned, due in 1 month)
  Overdue:     2 courses (triggers alerts)
  Certs:       $demoCertCount (1 expiring within 30 days)
  Audit Trail: 9 entries
═══════════════════════════════════════════════════════════════════════════════
''';

    // Provision Serverpod auth accounts
    try {
      final authResult = await provisionAuthAccounts(session);
      result += '\n$authResult';
    } catch (e) {
      result += '\nAuth provisioning failed: $e';
    }

    return result;
  }

  /// Provisions Serverpod auth accounts for all PharmaUser records.
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

  /// Fix admin passwords by re-provisioning them
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
        final existing = await admin.findAccount(session, email: email);
        if (existing == null) {
          final authUser = await AuthServices.instance.authUsers.create(session);
          await admin.createEmailAuthentication(
            session,
            authUserId: authUser.id,
            email: email,
            password: _seedPassword,
          );
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
          try {
            await session.db.unsafeQuery(
              r'''DELETE FROM serverpod_auth_core_email_auth
                  WHERE "authUserId" = @authUserId::uuid''',
              parameters: QueryParameters.named({
                'authUserId': existing.id!.toString(),
              }),
            );
          } catch (e) {
            session.log('Could not delete old email auth: $e');
          }
          try {
            await admin.createEmailAuthentication(
              session,
              authUserId: existing.id!,
              email: email,
              password: _seedPassword,
            );
          } catch (e) {
            session.log('Could not create new email auth: $e');
          }
        }
        fixed++;
      } catch (e) {
        failed++;
        session.log('Failed to fix password for $email: $e');
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
