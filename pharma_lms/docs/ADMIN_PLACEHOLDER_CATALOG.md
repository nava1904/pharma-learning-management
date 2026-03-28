# Admin UI — `AdminPlaceholderTable` usage catalog

Widget: `lib/features/admin_portal/widgets/admin_page_frame.dart` (`AdminPlaceholderTable`).

Screens that still show placeholder tables (wire to endpoints or explicitly defer):

| Area | File (portal path) | Notes |
|------|-------------------|--------|
| Certificates | `admin_portal/certificates/certificate_screens.dart` | Templates / list tab placeholders |
| Analytics | `admin_portal/analytics/analytics_screens.dart` | Section placeholder |
| System | `admin_portal/system/system_screens.dart` | System tables |
| Dashboard V2 | `admin_portal/dashboard/admin_dashboard_screen_v2.dart` | Queue/detail fallbacks |
| Enrollments | `admin_portal/enrollments/enrollment_screens.dart` | List placeholder |
| Job specs | `admin_portal/job_specs/job_spec_screens.dart` | Section placeholder |
| Notifications | `admin_portal/notifications/notification_screens.dart` | Detail placeholder |
| Audit / CAPA | `admin_portal/audit_capa/audit_capa_screens.dart` | One tab still placeholder; integrity check screen uses real API |
| Batches | `admin_portal/batches/batch_screens.dart` | Section placeholder |
| Users | `admin_portal/users/users_screens.dart` | Sub-view placeholder |
| Reports | `admin_portal/reports/report_screens.dart` | Report placeholder |
| Assessments | `admin_portal/assessments/assessment_screens.dart` | Template screens |
| Documents | `admin_portal/documents/document_screens.dart` | Library placeholder |
| Courses | `admin_portal/courses/course_screens.dart` | Sub-section placeholder |

Duplicate legacy tree under `lib/features/admin/` (non-`admin_portal`) mirrors several of the above; prefer consolidating on `admin_portal` imports.

## Provider hygiene

- **`admin_providers_v2.dart`** — active admin data layer.
- **`admin_providers.dart`** — deprecated; do not import from new screens (see file header).

## Trainer batches

- `trainer_batch_providers.dart` — documents empty roster until a dedicated roster API exists; list/detail use `trainingBatch` client where applicable.
