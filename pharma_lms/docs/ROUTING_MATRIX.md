# Pharma LMS — routing matrix (nav vs GoRouter)

Single source of routes: `pharma_lms_flutter/lib/routes/app_router.dart`. Shells: `admin_shell_v2.dart`, `employee_shell_v2.dart`, `trainer_shell_v2.dart`, `app_layout.dart`.

## Admin redirects (alias → canonical)

| Alias path | Resolves to |
|------------|-------------|
| `/admin/users` | `/admin/users/directory` |
| `/admin/compliance` | `/admin/reports/compliance` |
| `/admin/courses` | `/admin/courses/catalogue` |
| `/admin/enrollments` | `/admin/enrollments/list` |
| `/admin/profile` | `ProfileSettingsScreen` (no redirect) |

## AppLayout / catalog (shared)

| Path | Notes |
|------|--------|
| `/courses`, `/learning`, `/training-timeline` | Catalog-style; role guard: employee + admin (not trainer-only default). |
| `/assessments` | Redirect → `/employee/assessments`. |
| `/certificates` | Redirect → `/employee`. |
| `/course-viewer/:courseId` | Deep link from catalog. |

## Employee shell (`/employee/...`)

| Path fragment | Typical screen |
|---------------|----------------|
| `assessment/:courseId` | `AssessmentScreenV2` |
| `course/:courseId` | Course viewer flow |
| `my-training`, `catalog`, `training-history`, `credentials`, `profile`, `assessments`, `lessons`, `downloads`, `sessions`, `operator` | See `app_router.dart` builders |

## Trainer shell (`/trainer/...`)

Trainer assessments, courses, batches, SOP tools, etc. — see `GoRoute` children under `/trainer` in `app_router.dart`.

## Compliance / audit (top-level)

Examples: `/qa`, auditor routes, `/documents`, `/assessment-v2/:courseVersionId`, public `/verify/...` (allowed unauthenticated per `auth_provider`).

## Course entry points (documented canonical use)

- **`/employee/course/:courseId`** — preferred for logged-in employee flows from the employee shell.
- **`/course-viewer/:courseId`** — AppLayout catalog deep link.
- **`/course/:courseId`** — legacy/top-level if still registered; align new links to employee or viewer as product dictates.

When adding sidebar or `context.go` targets, match a `path:` in `app_router.dart` or add a **redirect** row to this table.
