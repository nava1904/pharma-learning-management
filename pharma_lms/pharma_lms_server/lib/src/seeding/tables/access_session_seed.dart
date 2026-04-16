import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../seed_context.dart';

/// Seeds access logs, user sessions, standalone assignments,
/// training waivers, SME assignments, and SME review comments.
class AccessSessionSeed {
  // ── Access Logs ───────────────────────────────────────────────────────────
  static Future<void> insertAccessLogs(
    Session session,
    SeedContext ctx,
  ) async {
    final rng = Random(33);
    final allUsers = [
      ...ctx.learnerIds,
      ...ctx.trainerIds,
      ...ctx.qaUserIds,
      ...ctx.adminUserIds,
    ];

    // 50 login events over the past 30 days
    for (var i = 0; i < 50; i++) {
      final userId = allUsers[i % allUsers.length];
      final dayOffset = -rng.nextInt(30);

      await AccessLog.db.insertRow(
        session,
        AccessLog(
          userId: userId,
          action: 'login',
          ipAddress: '10.0.${rng.nextInt(5)}.${100 + rng.nextInt(155)}',
          userAgent: i % 3 == 0
              ? 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120'
              : i % 3 == 1
                  ? 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Safari/605'
                  : 'PharmaLMS-Flutter/1.0 (Android 14)',
          timestamp: ctx.dt(dayOffset),
          success: i != 47, // One failed login
        ),
      );

      // 70% have a corresponding logout
      if (rng.nextDouble() < 0.7) {
        await AccessLog.db.insertRow(
          session,
          AccessLog(
            userId: userId,
            action: 'logout',
            ipAddress: '10.0.${rng.nextInt(5)}.${100 + rng.nextInt(155)}',
            timestamp: ctx.dt(dayOffset).add(Duration(minutes: 30 + rng.nextInt(180))),
            success: true,
          ),
        );
      }
    }
  }

  // ── User Sessions ─────────────────────────────────────────────────────────
  static Future<void> insertUserSessions(
    Session session,
    SeedContext ctx,
  ) async {
    final rng = Random(44);
    final allUsers = [
      ...ctx.learnerIds.take(20),
      ...ctx.trainerIds,
      ...ctx.qaUserIds,
      ...ctx.adminUserIds,
    ];

    for (var i = 0; i < allUsers.length; i++) {
      final userId = allUsers[i];
      final startDay = -rng.nextInt(14);
      final startTime = ctx.dt(startDay);

      final endReasons = ['manual_logout', 'timeout', null];
      final endReason = endReasons[i % 3];
      final ended = endReason != null;

      await UserSession.db.insertRow(
        session,
        UserSession(
          userId: userId,
          startedAt: startTime,
          endedAt: ended
              ? startTime.add(Duration(minutes: 15 + rng.nextInt(120)))
              : null,
          ipAddress: '10.0.${rng.nextInt(5)}.${100 + rng.nextInt(155)}',
          endReason: endReason,
          isMfaVerified: i % 4 != 3,
        ),
      );
    }
  }

  // ── Standalone Assignments ────────────────────────────────────────────────
  static Future<void> insertStandaloneAssignments(
    Session session,
    SeedContext ctx,
  ) async {
    if (ctx.trainerIds.isEmpty) return;

    final assignments = <({
      String title,
      String instructions,
      int trainerIdx,
      String contentKind,
      String targetType,
      int? targetDeptIdx,
      String status,
      int dueDaysOffset,
    })>[
      (
        title: 'GMP Knowledge Check — Q1 2026',
        instructions:
            'Complete all 10 questions. Minimum passing score: 80%. Open book permitted.',
        trainerIdx: 0,
        contentKind: 'mcq',
        targetType: 'department',
        targetDeptIdx: 0, // QA
        status: 'published',
        dueDaysOffset: 14,
      ),
      (
        title: 'Deviation Investigation Report — Case Study',
        instructions:
            'Analyze the attached deviation scenario. Write a 500-word investigation report including root cause analysis using the 5-Why method.',
        trainerIdx: 1,
        contentKind: 'open_ended',
        targetType: 'department',
        targetDeptIdx: 2, // Manufacturing
        status: 'published',
        dueDaysOffset: 21,
      ),
      (
        title: 'Data Integrity Self-Assessment',
        instructions:
            'Answer the following questions about ALCOA+ principles as applied to your daily work.',
        trainerIdx: 2,
        contentKind: 'mixed',
        targetType: 'department',
        targetDeptIdx: 1, // QC
        status: 'published',
        dueDaysOffset: 7,
      ),
      (
        title: 'New Hire Orientation Quiz',
        instructions:
            'Complete this quiz within 48 hours of starting. All questions are mandatory.',
        trainerIdx: 0,
        contentKind: 'mcq',
        targetType: 'department',
        targetDeptIdx: 7, // Learning & Development
        status: 'draft',
        dueDaysOffset: 30,
      ),
    ];

    for (final a in assignments) {
      final sa = await StandaloneAssignment.db.insertRow(
        session,
        StandaloneAssignment(
          organizationId: ctx.orgId,
          createdById: ctx.trainerIds[a.trainerIdx],
          title: a.title,
          instructions: a.instructions,
          dueAt: ctx.dt(a.dueDaysOffset),
          contentKind: a.contentKind,
          targetType: a.targetType,
          targetDepartmentId: a.targetDeptIdx != null
              ? ctx.deptIds[a.targetDeptIdx!]
              : null,
          status: a.status,
          publishedAt: a.status == 'published' ? ctx.dt(-7) : null,
          createdAt: ctx.dt(-10),
        ),
      );

      // Add recipients for published assignments
      if (a.status == 'published') {
        // Assign to 5 learners in the target department
        for (var li = 0; li < 5 && li < ctx.learnerIds.length; li++) {
          final learnerIdx = (a.targetDeptIdx ?? 0) * 10 + li;
          if (learnerIdx >= ctx.learnerIds.length) break;

          final statuses = ['pending', 'submitted', 'graded', 'pending', 'submitted'];
          final status = statuses[li];

          await StandaloneAssignmentRecipient.db.insertRow(
            session,
            StandaloneAssignmentRecipient(
              assignmentId: sa.id!,
              userId: ctx.learnerIds[learnerIdx],
              status: status,
              submittedAt: status != 'pending' ? ctx.dt(-3 + li) : null,
              responseJson: status != 'pending'
                  ? '{"answers":["A","B","C","A","D"]}'
                  : null,
              grade: status == 'graded' ? 85 + li * 3 : null,
              feedback: status == 'graded'
                  ? 'Good understanding of core concepts. Review section 3.'
                  : null,
              gradedAt: status == 'graded' ? ctx.dt(-1) : null,
              gradedById: status == 'graded'
                  ? ctx.trainerIds[a.trainerIdx]
                  : null,
              createdAt: ctx.dt(-7),
            ),
          );
        }
      }
    }
  }

  // ── Training Waivers ──────────────────────────────────────────────────────
  static Future<void> insertTrainingWaivers(
    Session session,
    SeedContext ctx,
  ) async {
    if (ctx.learnerIds.length < 5 || ctx.courseIds.isEmpty) return;

    final waivers = <({
      int learnerIdx,
      int courseIdx,
      String reason,
      String status,
      int? approverQaIdx,
    })>[
      (
        learnerIdx: 10,
        courseIdx: 4, // Cold Chain Management
        reason: 'Employee transferred from cold chain to packaging. No longer handling temperature-sensitive materials.',
        status: 'approved',
        approverQaIdx: 0,
      ),
      (
        learnerIdx: 25,
        courseIdx: 9, // Stability Studies
        reason: 'Prior certification from USFDA-approved facility. Equivalent training documented.',
        status: 'approved',
        approverQaIdx: 1,
      ),
      (
        learnerIdx: 50,
        courseIdx: 5, // Aseptic Technique
        reason: 'Medical restriction — unable to enter cleanroom. Alternative training requested.',
        status: 'pending',
        approverQaIdx: null,
      ),
      (
        learnerIdx: 75,
        courseIdx: 8, // EHS Fundamentals
        reason: 'Completed equivalent OSHA 30-hour certification externally.',
        status: 'rejected',
        approverQaIdx: 2,
      ),
    ];

    for (final w in waivers) {
      final requestedBy = ctx.trainerIds.isNotEmpty
          ? ctx.trainerIds[0]
          : ctx.adminUserIds[0];

      await TrainingWaiver.db.insertRow(
        session,
        TrainingWaiver(
          userId: ctx.learnerIds[w.learnerIdx],
          courseId: ctx.courseIds[w.courseIdx],
          requestedById: requestedBy,
          requestedAt: ctx.dt(-30),
          requestReason: w.reason,
          status: w.status,
          approvedById: w.approverQaIdx != null
              ? ctx.qaUserIds[w.approverQaIdx!]
              : null,
          approvedAt: w.status == 'approved' ? ctx.dt(-25) : null,
          rejectionReason: w.status == 'rejected'
              ? 'External certification does not cover PTI-specific EHS requirements.'
              : null,
          expiresAt: w.status == 'approved' ? ctx.dt(335) : null,
        ),
      );
    }
  }

  // ── SME Assignments & Review Comments ─────────────────────────────────────
  static Future<void> insertSmeData(
    Session session,
    SeedContext ctx,
  ) async {
    if (ctx.qaUserIds.isEmpty || ctx.courseIds.isEmpty || ctx.courseVersionIds.isEmpty) return;

    // Assign QA users as SME reviewers on courses
    for (var i = 0; i < 3 && i < ctx.qaUserIds.length; i++) {
      final smeAssignment = await SmeAssignment.db.insertRow(
        session,
        SmeAssignment(
          courseId: ctx.courseIds[i],
          courseVersionId: ctx.courseVersionIds[i],
          smeUserId: ctx.qaUserIds[i],
          invitedById: ctx.trainerIds.isNotEmpty
              ? ctx.trainerIds[i % ctx.trainerIds.length]
              : ctx.adminUserIds[0],
          status: i == 0 ? 'completed' : 'active',
          invitedAt: ctx.dt(-45 + i * 10),
        ),
      );

      // Add review comments for each assignment
      final comments = <({String sectionRef, String severity, String body, bool resolved})>[
        (
          sectionRef: 'module-1/lesson-1',
          severity: 'note',
          body: 'Consider adding a real-world case study here to illustrate the concept.',
          resolved: true,
        ),
        (
          sectionRef: 'module-2/lesson-2',
          severity: 'major',
          body: 'SOP reference SOP-GMP-001 v1.0 is outdated. Update to v2.0 per latest revision.',
          resolved: i == 0,
        ),
        (
          sectionRef: 'assessment',
          severity: 'critical',
          body: 'Question 3 has two correct answers in the current option set. Fix before approval.',
          resolved: i == 0,
        ),
      ];

      for (final c in comments) {
        await SmeReviewComment.db.insertRow(
          session,
          SmeReviewComment(
            courseVersionId: ctx.courseVersionIds[i],
            authorId: ctx.qaUserIds[i],
            sectionRef: c.sectionRef,
            severity: c.severity,
            body: c.body,
            resolved: c.resolved,
            trainerResponse: c.resolved
                ? 'Updated as requested. Please re-review.'
                : null,
            resolvedAt: c.resolved ? ctx.dt(-20 + i * 5) : null,
            createdAt: ctx.dt(-40 + i * 10),
          ),
        );
      }
    }
  }

  // ── Learner-Trainer Messages ──────────────────────────────────────────────
  static Future<void> insertMessages(
    Session session,
    SeedContext ctx,
  ) async {
    if (ctx.learnerIds.isEmpty ||
        ctx.trainerIds.isEmpty ||
        ctx.courseVersionIds.isEmpty) {
      return;
    }

    final conversations = <({
      int learnerIdx,
      int trainerIdx,
      int cvIdx,
      List<({bool fromLearner, String body})> messages,
    })>[
      (
        learnerIdx: 0,
        trainerIdx: 0,
        cvIdx: 0,
        messages: [
          (fromLearner: true, body: 'Dr. Venkataraman, I have a question about Module 2 — the GMP deviation reporting workflow. Is form DEV-001 still the current version?'),
          (fromLearner: false, body: 'Good question, Ramesh. Yes, DEV-001 v3.0 is the current version. You can find it in the document library under SOPs > Quality.'),
          (fromLearner: true, body: 'Thank you! I found it. The lesson references v2.0 — should that be updated?'),
          (fromLearner: false, body: 'You\'re right, I\'ll update the lesson content. Thanks for catching that.'),
        ],
      ),
      (
        learnerIdx: 5,
        trainerIdx: 1,
        cvIdx: 1,
        messages: [
          (fromLearner: true, body: 'Ms. Krishnamurthy, I\'m having trouble understanding the audit trail requirements in 21 CFR Part 11 Section 11.10(e). Could you explain?'),
          (fromLearner: false, body: 'Of course. Section 11.10(e) requires that all changes to electronic records include the date/time, the identity of the person making the change, and the reason for the change. Think of it as a digital version of the paper amendment process.'),
          (fromLearner: true, body: 'That makes more sense now. So every field edit needs to be captured with who/when/why?'),
          (fromLearner: false, body: 'Exactly. And the original value must be preserved — you can\'t overwrite it. That\'s what makes it an audit trail vs. just an edit log.'),
        ],
      ),
      (
        learnerIdx: 15,
        trainerIdx: 2,
        cvIdx: 5,
        messages: [
          (fromLearner: true, body: 'Dr. Subramaniam, when is the next practical session for aseptic gowning? I need to complete my observation log.'),
          (fromLearner: false, body: 'The next session is scheduled for this Friday at the Pune cleanroom. Please sign up through the batch calendar. Maximum 6 participants per session.'),
        ],
      ),
    ];

    for (final conv in conversations) {
      final learnerId = ctx.learnerIds[conv.learnerIdx];
      final trainerId = ctx.trainerIds[conv.trainerIdx];
      final cvId = ctx.courseVersionIds[conv.cvIdx];

      for (var mi = 0; mi < conv.messages.length; mi++) {
        final msg = conv.messages[mi];
        await LearnerTrainerMessage.db.insertRow(
          session,
          LearnerTrainerMessage(
            courseVersionId: cvId,
            fromUserId: msg.fromLearner ? learnerId : trainerId,
            toUserId: msg.fromLearner ? trainerId : learnerId,
            body: msg.body,
            readAt: mi < conv.messages.length - 1 ? ctx.dt(-5 + mi) : null,
            createdAt: ctx.dt(-7 + mi),
          ),
        );
      }
    }
  }
}
