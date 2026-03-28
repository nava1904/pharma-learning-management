# Pharma LMS — realistic gaps vs industry (backlog)

This document extends the routing/API plan with **product and architecture** items. Implementation status is **roadmap** unless noted in code.

## Strong fit today (partial list)

- Versioned courses, assessments, enrollments, certificates, documents / SOP linkage, audit feeds, QA hooks, compliance/analytics endpoints, ILT batches, access review, validation-oriented system screens.

## Supplier / external learners

- **Gap:** Packaged training for CMOs/suppliers, credential handoff, firewall-friendly access.
- **Backlog:** External identity, scoped org, training package entity, completion export.

## Periodic SOP review

- **Gap:** Automated “next review due” queues beyond ad-hoc reports.
- **Backlog:** Link document metadata to review cadence; tasks and notifications.

## HRIS integration

- **Gap:** Deep sync of job title, manager, site, termination → access and assignments.
- **Backlog:** Connector spec, idempotent user upsert, deprovisioning rules.

## Curricula (grouped requirements)

- **Model:** `Curriculum`, `CurriculumCourse` protocol classes added under `pharma_lms_server` (migration required).
- **Backlog:** UI for curriculum editor, assignment by curriculum, credit across roles.

## Document lifecycle → training automation

- **Today:** `CourseSopLink`-style manual linkage; `EventService` / Kafka paths can drive events (see `event_service.dart` comments).
- **Backlog:** When `DocumentVersion` becomes **Effective**, job or consumer creates/updates `TrainingAssignment` (avoid duplicating logic in HTTP layer if async pipeline already exists).

## MFA / biometric / SSO

- **Model:** `PharmaUser` extended with optional `customMetadataJson`, `biometricCredentialId` (and related training step-up via existing endpoints where wired).
- **Backlog:** Explicit MFA enrollment UX coverage, OIDC/SSO roadmap, policy matrix in validation docs.

## Metadata / property bag

- **Model:** JSON bag on `PharmaUser`, `Course` for site-specific fields without constant codegen churn.
- **Backlog:** Admin UI with validation rules; audit on change.

## ILT facility / capacity

- **Model:** `Facility` entity; optional `facility` on `TrainingBatch`.
- **Backlog:** Roster capacity checks, waitlist, cleanroom overbooking prevention.

## Manufacturing — operator / equipment QR

- **UI stub:** `/employee/operator` — `operator_qualification_screen.dart`.
- **Backlog:** Equipment/asset model, QR resolution, `TrainingRecord` currency for asset context.

## MSL / Medical Affairs simulations

- **Model stub:** `SimulationAttempt` (protocol).
- **Backlog:** `BehavioralMetric`, content types, coach dashboards.

## AI / per-attempt assessments

- **Gap:** Fixed pools vs infinite AI-generated items.
- **Backlog:** Approved question pools, human-in-the-loop generation (aligns with trainer AI tools), policy for validated environments.

## Audit readiness (UX)

- Server **HMAC** integrity for audit rows.
- **UI:** Auditor-readable trail, per-row integrity indicator, `runAuditTrailIntegrityCheck` (see admin audit CAPA screens).

---

Apply DB migrations after pulling server protocol changes (e.g. under `pharma_lms_server/migrations/`).
