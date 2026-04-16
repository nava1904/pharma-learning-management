import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../seed_context.dart';

/// Seeds quality events, CAPAs, and inspection records for compliance demos.
class QualitySeed {
  static Future<void> insert(Session session, SeedContext ctx) async {
    // ── Quality Events & CAPAs ──────────────────────────────────────────────
    final qualityEvents = <({
      String eventType,
      String title,
      String status,
      int siteIdx,
      int offsetDays,
    })>[
      (
        eventType: 'deviation',
        title: 'Temperature excursion in Warehouse B — raw materials',
        status: 'open',
        siteIdx: 0,
        offsetDays: -5,
      ),
      (
        eventType: 'deviation',
        title: 'OOS result in Batch PUN-2026-0342 dissolution test',
        status: 'investigation',
        siteIdx: 1,
        offsetDays: -12,
      ),
      (
        eventType: 'capa',
        title: 'CAPA-001: Recurring label mix-up in packaging line 3',
        status: 'root_cause_analysis',
        siteIdx: 1,
        offsetDays: -30,
      ),
      (
        eventType: 'capa',
        title: 'CAPA-002: Incomplete training records — Q4 audit finding',
        status: 'implementation',
        siteIdx: 0,
        offsetDays: -60,
      ),
      (
        eventType: 'capa',
        title: 'CAPA-003: Cleaning validation failure on Reactor R-201',
        status: 'effectiveness_check',
        siteIdx: 3,
        offsetDays: -90,
      ),
      (
        eventType: 'capa',
        title: 'CAPA-004: Data integrity gap in HPLC lab notebook',
        status: 'closed',
        siteIdx: 2,
        offsetDays: -120,
      ),
      (
        eventType: 'change_control',
        title: 'CC-001: SOP revision for aseptic gowning procedure',
        status: 'pending_approval',
        siteIdx: 0,
        offsetDays: -15,
      ),
      (
        eventType: 'change_control',
        title: 'CC-002: New environmental monitoring sampling points',
        status: 'approved',
        siteIdx: 4,
        offsetDays: -45,
      ),
      (
        eventType: 'deviation',
        title: 'Power interruption during stability chamber operation',
        status: 'closed',
        siteIdx: 2,
        offsetDays: -75,
      ),
      (
        eventType: 'deviation',
        title: 'Missing batch record signature on page 3 of BR-4421',
        status: 'closed',
        siteIdx: 1,
        offsetDays: -100,
      ),
    ];

    final qualityEventIds = <int>[];
    for (final qe in qualityEvents) {
      final event = await QualityEvent.db.insertRow(
        session,
        QualityEvent(
          eventType: qe.eventType,
          title: qe.title,
          status: qe.status,
          siteId: ctx.siteIds[qe.siteIdx],
          createdAt: ctx.dt(qe.offsetDays),
        ),
      );
      qualityEventIds.add(event.id!);
    }

    // CAPAs linked to quality events (indices 2-5 are CAPA type events)
    final capaData = <({
      int qeIdx,
      String description,
      String rootCause,
      bool trainingRequired,
      String status,
    })>[
      (
        qeIdx: 2,
        description:
            'Implement barcode scanning verification at label dispensing station',
        rootCause:
            'No automated verification between printed label and batch record',
        trainingRequired: true,
        status: 'implementation',
      ),
      (
        qeIdx: 3,
        description:
            'Implement digital training acknowledgement with e-signatures',
        rootCause:
            'Manual paper-based training record system prone to gaps',
        trainingRequired: true,
        status: 'implementation',
      ),
      (
        qeIdx: 4,
        description:
            'Redesign cleaning validation protocol for large-scale reactors',
        rootCause:
            'Existing protocol did not account for new product residue limits',
        trainingRequired: true,
        status: 'effectiveness_check',
      ),
      (
        qeIdx: 5,
        description:
            'Migrate HPLC lab notebooks to electronic system with audit trail',
        rootCause:
            'Manual notebook entries lacked traceability and ALCOA compliance',
        trainingRequired: false,
        status: 'closed',
      ),
    ];

    for (final c in capaData) {
      await Capa.db.insertRow(
        session,
        Capa(
          qualityEventId: qualityEventIds[c.qeIdx],
          description: c.description,
          rootCause: c.rootCause,
          trainingRequired: c.trainingRequired,
          status: c.status,
        ),
      );
    }

    // ── Inspection Records ──────────────────────────────────────────────────
    final inspections = <({
      String inspectionType,
      String status,
      int siteIdx,
      int offsetDays,
      String? inspectorNames,
      String? outcome,
      int? findingsCount,
    })>[
      (
        inspectionType: 'internal',
        status: 'completed',
        siteIdx: 0,
        offsetDays: -90,
        inspectorNames: 'Ananya Kulkarni, Rajeev Menon',
        outcome: 'observations',
        findingsCount: 3,
      ),
      (
        inspectionType: 'fda',
        status: 'completed',
        siteIdx: 1,
        offsetDays: -180,
        inspectorNames: 'Dr. Sarah Chen (FDA CDER)',
        outcome: 'no_findings',
        findingsCount: 0,
      ),
      (
        inspectionType: 'ema',
        status: 'completed',
        siteIdx: 0,
        offsetDays: -270,
        inspectorNames: 'Dr. Hans Mueller (EMA)',
        outcome: 'observations',
        findingsCount: 2,
      ),
      (
        inspectionType: 'internal',
        status: 'scheduled',
        siteIdx: 2,
        offsetDays: 30,
        inspectorNames: 'Priti Deshmukh',
        outcome: null,
        findingsCount: null,
      ),
      (
        inspectionType: 'customer',
        status: 'completed',
        siteIdx: 3,
        offsetDays: -45,
        inspectorNames: 'Mark Thompson (Pfizer QA)',
        outcome: 'no_findings',
        findingsCount: 0,
      ),
    ];

    for (final insp in inspections) {
      await InspectionRecord.db.insertRow(
        session,
        InspectionRecord(
          inspectionType: insp.inspectionType,
          status: insp.status,
          siteId: ctx.siteIds[insp.siteIdx],
          scheduledDate: ctx.dt(insp.offsetDays),
          inspectorNames: insp.inspectorNames,
          outcome: insp.outcome,
          findingsCount: insp.findingsCount,
          createdById: ctx.qaUserIds.isNotEmpty
              ? ctx.qaUserIds[0]
              : ctx.adminUserIds[0],
          createdAt: ctx.dt(insp.offsetDays - 14),
        ),
      );
    }

    // ── Inspection Reports ──────────────────────────────────────────────────
    await InspectionReport.db.insertRow(
      session,
      InspectionReport(
        organizationId: ctx.orgId,
        siteId: ctx.siteIds[0],
        inspector: 'Ananya Kulkarni',
        inspectionDate: ctx.dt(-90),
        findingsJson:
            '["Training records for 3 employees missing e-signatures","Cleaning log for Room C-204 not completed for 2 days","Minor label discrepancy on WIP containers"]',
        status: 'closed',
      ),
    );
    await InspectionReport.db.insertRow(
      session,
      InspectionReport(
        organizationId: ctx.orgId,
        siteId: ctx.siteIds[1],
        inspector: 'Dr. Sarah Chen (FDA CDER)',
        inspectionDate: ctx.dt(-180),
        findingsJson: '[]',
        status: 'closed',
      ),
    );
  }
}
