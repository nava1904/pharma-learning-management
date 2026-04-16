import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../seed_context.dart';

/// Seeds training batches, participants, live classes, batch announcements,
/// and attendance records for ILT (Instructor-Led Training) demos.
class TrainingBatchSeed {
  static Future<void> insert(Session session, SeedContext ctx) async {
    if (ctx.courseVersionIds.isEmpty || ctx.trainerIds.isEmpty) return;

    final batches = <({
      String name,
      int cvIdx,
      int trainerIdx,
      int startOffset,
      int endOffset,
      int capacity,
      String status,
      String? location,
      String? medium,
      String? notes,
    })>[
      (
        name: 'GMP Fundamentals — Jan 2026 Cohort',
        cvIdx: 0,
        trainerIdx: 0,
        startOffset: -60,
        endOffset: -30,
        capacity: 30,
        status: 'completed',
        location: 'Mumbai HQ — Training Room A',
        medium: 'offline',
        notes: 'Mandatory GMP training for new hires. All participants passed.',
      ),
      (
        name: '21 CFR Part 11 — Online Feb Cohort',
        cvIdx: 1,
        trainerIdx: 1,
        startOffset: -45,
        endOffset: -15,
        capacity: 40,
        status: 'completed',
        location: null,
        medium: 'online',
        notes: 'Electronic records compliance for IT and QA departments.',
      ),
      (
        name: 'Aseptic Technique — Mar 2026 Hands-On',
        cvIdx: 5,
        trainerIdx: 2,
        startOffset: -14,
        endOffset: 14,
        capacity: 15,
        status: 'active',
        location: 'Pune Manufacturing — Cleanroom Training Suite',
        medium: 'hybrid',
        notes: 'Practical cleanroom gowning and aseptic processing.',
      ),
      (
        name: 'CAPA & Root Cause — Apr Cohort',
        cvIdx: 6,
        trainerIdx: 3,
        startOffset: 7,
        endOffset: 35,
        capacity: 25,
        status: 'scheduled',
        location: 'Hyderabad R&D — Conference Hall B',
        medium: 'offline',
        notes: 'Cross-functional CAPA training covering Ishikawa and 5-Why methods.',
      ),
      (
        name: 'Data Integrity ALCOA+ — Refresher',
        cvIdx: 7,
        trainerIdx: 4,
        startOffset: 14,
        endOffset: 28,
        capacity: 50,
        status: 'scheduled',
        location: null,
        medium: 'online',
        notes: 'Annual refresher for all lab personnel.',
      ),
    ];

    for (var bi = 0; bi < batches.length; bi++) {
      final b = batches[bi];

      // Distribute learners across batches
      final startLearner = bi * 15;
      final batchLearnerIds = <int>[];
      for (var li = 0; li < 15 && (startLearner + li) < ctx.learnerIds.length; li++) {
        batchLearnerIds.add(ctx.learnerIds[startLearner + li]);
      }

      final completedInBatch = b.status == 'completed' ? batchLearnerIds.length : 0;

      final batch = await TrainingBatch.db.insertRow(
        session,
        TrainingBatch(
          organizationId: ctx.orgId,
          courseVersionId: ctx.courseVersionIds[b.cvIdx],
          name: b.name,
          instructorId: ctx.trainerIds[b.trainerIdx],
          startDate: ctx.dt(b.startOffset),
          endDate: ctx.dt(b.endOffset),
          capacity: b.capacity,
          enrolledCount: batchLearnerIds.length,
          completedCount: completedInBatch,
          status: b.status,
          location: b.location,
          medium: b.medium,
          notes: b.notes,
          createdAt: ctx.dt(b.startOffset - 14),
        ),
      );

      // ── Participants ────────────────────────────────────────────────────
      for (final uid in batchLearnerIds) {
        await TrainingBatchParticipant.db.insertRow(
          session,
          TrainingBatchParticipant(
            batchId: batch.id!,
            userId: uid,
            role: 'learner',
          ),
        );
      }
      // Add a mentor to each batch
      if (ctx.trainerIds.length > 1) {
        await TrainingBatchParticipant.db.insertRow(
          session,
          TrainingBatchParticipant(
            batchId: batch.id!,
            userId: ctx.trainerIds[(b.trainerIdx + 1) % ctx.trainerIds.length],
            role: 'mentor',
          ),
        );
      }

      // ── Live Classes ────────────────────────────────────────────────────
      for (var lc = 0; lc < 3; lc++) {
        final lcOffset = b.startOffset + lc * 7;
        await LiveClass.db.insertRow(
          session,
          LiveClass(
            batchId: batch.id!,
            title: '${b.name} — Session ${lc + 1}',
            description: lc == 0
                ? 'Introduction and overview'
                : lc == 1
                    ? 'Deep dive and case studies'
                    : 'Assessment prep and Q&A',
            scheduledAt: ctx.dt(lcOffset),
            durationMinutes: 90,
            meetingUrl: b.medium != 'offline'
                ? 'https://meet.pharmatech.in/batch-${batch.id}-session-${lc + 1}'
                : null,
            autoRecording: b.medium != 'offline',
            createdById: ctx.trainerIds[b.trainerIdx],
            createdAt: ctx.dt(b.startOffset - 7),
          ),
        );
      }

      // ── Batch Announcements ─────────────────────────────────────────────
      await BatchAnnouncement.db.insertRow(
        session,
        BatchAnnouncement(
          batchId: batch.id!,
          title: 'Welcome to ${b.name}',
          body: 'Please review the pre-read materials before Session 1. '
              'Contact your instructor if you have any questions.',
          kind: 'general',
          createdById: ctx.trainerIds[b.trainerIdx],
          createdAt: ctx.dt(b.startOffset - 3),
        ),
      );

      if (b.status == 'active' || b.status == 'completed') {
        await BatchAnnouncement.db.insertRow(
          session,
          BatchAnnouncement(
            batchId: batch.id!,
            title: 'Session 1 recording available',
            body: 'The recording for Session 1 has been uploaded. '
                'Please review if you missed the live session.',
            kind: 'live_session',
            createdById: ctx.trainerIds[b.trainerIdx],
            createdAt: ctx.dt(b.startOffset + 1),
          ),
        );
      }

      // ── Attendance Records (for completed/active batches) ───────────────
      if (b.status == 'completed' || b.status == 'active') {
        for (var li = 0; li < batchLearnerIds.length; li++) {
          final statuses = ['present', 'present', 'present', 'late', 'excused', 'absent'];
          final attStatus = statuses[(li + bi) % statuses.length];

          await BatchAttendanceRecord.db.insertRow(
            session,
            BatchAttendanceRecord(
              batchId: batch.id!,
              userId: batchLearnerIds[li],
              status: attStatus,
              markedAt: ctx.dt(b.startOffset + 1),
              markedById: ctx.trainerIds[b.trainerIdx],
            ),
          );
        }
      }
    }
  }
}
