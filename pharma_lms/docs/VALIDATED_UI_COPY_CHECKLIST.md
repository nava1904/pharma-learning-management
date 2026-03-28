# Validated release — UI copy checklist (ALCOA+ / legibility)

Use before tagging a validated build. Goal: **Accurate, consistent, GxP-appropriate** wording in employee, trainer, and admin surfaces.

## Terminology

- Use **Assessment** (not “quiz”) for scored knowledge checks tied to training records.
- Use **Certification** / **certificate** consistently; avoid invented spellings.
- Prefer **Training record**, **enrollment**, **assignment** per domain model (avoid generic “course” where policy means assignment).
- Navigation labels must match the **screen title** and route purpose.

## Pass criteria

- [ ] Grep for common typos: `Assesment`, `Quie`, `Certfication`, `assesment`.
- [ ] Spot-check **admin** sidebar and **mobile drawer** labels vs `ROUTING_MATRIX.md`.
- [ ] Spot-check **trainer** and **employee** shell nav labels.
- [ ] **Part 11** flows: signature dialog shows printed name, UTC (or policy) time, meaning, and step-up auth where implemented (`part11_step_up_dialog.dart`, `esignature_screen.dart`).
- [ ] **Audit** views: human-readable event text; integrity column / verify action documented for auditors.
- [ ] No persona-inappropriate labels (e.g. consumer-education jargon) in production GxP paths.

## Optional automation

- String inventory / golden tests for critical screens (login, assessment start, certification, audit export).

## Recent copy alignment (examples)

- Employee dashboard: “Avg. assessment score”, activity “Assessment completed” (`employee_dashboard_v2.dart`).
