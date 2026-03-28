# Admin Portal Workflow Coverage

Source of truth: `admin_user_flows_pharma_lms (1).html`

Last reviewed: 2026-03-25

## Conventions
- Route mapping uses the exact GoRouter paths in `pharma_lms_flutter/lib/routes/app_router.dart`.
- Status values:
  - `Implemented (real data)` means the screen calls Riverpod providers that call real `pharma_lms_client` endpoints (no mock arrays / no `Future.delayed` stubs).
  - `Placeholder / mock data present` means UI renders mock arrays / hardcoded rows / “Coming Soon” ETA/status tables.
  - `Stubbed action` means the UI action is a TODO or uses `Future.delayed` instead of a real client call.
  - `Missing UI route` means there is no `/admin/*` screen that matches the HTML step.

## Access & identity (auth)
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Navigate to admin portal | Admin enters `/admin` with privileged session checks | `/admin` (dashboard), `/` (login) | Implemented (server-side auth; verify UI) | N/A |
| Credential + TOTP challenge | MFA challenge with lockout | `/` (login flow) | Implemented (UI auth; verify) | N/A |
| Privileged session issued | Privileged JWT/session provisioning | Server-side only | Missing UI route | N/A |
| IP allowlist check | Validate source IP against allowlist | Server-side only | Missing UI route | N/A |
| Inactivity timeout — 10 min | Idle timeout with heartbeat invalidation | Server-side only | Missing UI route | N/A |
| Break-glass / emergency access | Break-glass flow + immutable audit | Server-side only | Missing UI route | N/A |

## User management
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Provision new user | Create user (name/employee/email/dept/job title/roles) | `/admin/users/directory/create` | Implemented (likely; validate) | `lib/features/admin_portal/modules/01_user_identity/user_create_screen.dart` |
| Role assignment at creation | Roles saved at create time | `/admin/users/directory/create` | Implemented (likely; validate) | `user_create_screen.dart` |
| Initial credential dispatch | Send temp password + reset link | Server-side via create-user flow | Missing explicit UI | N/A |
| Bulk import via CSV/SCIM | CSV upload + row-level validation + error report | `/admin/users/directory/import` (note: verify nav paths) | Placeholder / mock data present | `.../user_bulk_import_screen.dart` (`TEMPORARY` simulate + simulated success) |
| Edit user profile / department transfer | Edit user + dept change impact | `/admin/users/directory/view/:userId/edit` | Implemented (likely; validate) | `user_edit_screen.dart` |
| Suspend user (temp inactive) | Suspend/temporary deactivate + session invalidation | `/admin/users/directory/view/:userId` | Missing distinction (suspend vs deactivate) | Needs parity vs “Suspend” semantics |
| Deactivate / offboard user | Deactivate user (offboarding) | `/admin/users/directory/view/:userId` | Implemented (likely; validate) | Deactivate confirmation UI exists |
| Periodic access review | Trigger and sign off access review | `/admin/users/access-review` | Stubbed action | `access_review_screen.dart` (`Future.delayed` stubs) |

## Roles & RBAC
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| View current role matrix | Role list + permissions + counts | Missing UI route | Missing UI route | No `/admin/roles` screen found |
| Create custom role | Create role (name/desc/permissions) | Missing UI route | Missing UI route | No `/admin/roles/create` screen found |
| Assign / revoke permissions | Update permissions for role | Partial (per-user roles toggled) | Stubbed action | `user_role_assignment_screen.dart` (hardcoded role state + TODO provider) |
| Scope constraints per role | Store JSON policies + enforce | Missing UI route | Missing UI route | No UI surfaced |
| Role change requires e-signature | E-sign flow for permission changes | Missing / not wired | Stubbed action | `user_role_assignment_screen.dart` |
| Separation of duties enforcement | SoD checks | Server-side | Missing UI route | Needs backend verification |
| Role audit report | Export role changes + e-sign log | Partial via user audit trail | Missing UI route (global) | `user_audit_trail_screen.dart` is mock today |

## Org structure
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Define org hierarchy | Company → Site → Division → Department tree | `/admin/users/org-tree` | Placeholder / mock data present | `users_screens.dart` (`AdminPlaceholderTable` “Coming Soon”) |
| Assign department compliance tier | GMP/GDP/GVP tier tagging | Missing UI route | Missing UI route | No dedicated tier editor found |
| Map departments to training plans | Link training plans to org nodes | `/admin/job-specs/*` (best-effort) | Missing UI route or partial | Needs mapping to actual providers |
| Site & facility management | Site metadata + timezone | Missing UI route | Missing UI route | No UI found |
| Org change impact assessment | Preview affected users/assignments | Missing UI route | Missing UI route | No UI found |

## Content & curriculum governance
### Course catalog
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| View full course catalog | List/search/filter + counts | `/admin/courses/catalogue` | Implemented (real data) | `course_screens.dart` (catalogue) |
| Designate course as mandatory | Toggle mandatory per role/dept | Missing UI route | Missing UI route | No admin UI found |
| Set requalification interval | Configure interval + renewal generation | Missing UI route | Missing UI route | No admin UI found |
| Archive / retire a course | Archive course with audit | Missing UI route | Missing UI route | No admin UI found |
| Cross-version comparison | Diff any two course versions | Missing UI route | Missing UI route | No UI found |
| Global course search & filter | Search/filter | `/admin/courses/catalogue` | Implemented (real data) | `course_screens.dart` |
| Course waiver management | Waive training for user/course | Missing UI route | Missing UI route | No admin UI found |

### Training plans & curricula
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Create training plan | Define plan + target roles/depts | `/admin/job-specs/create` | Placeholder / mock data present | Verify in `job_spec_screens.dart` |
| Add courses to plan | Sequence/due offsets/prereqs | `/admin/job-specs/create` or `/admin/job-specs/matrix` | Missing or partial | Verify in `job_spec_screens.dart` |
| Prerequisite chain enforcement | Block assignments until prerequisites complete | Server-side | Missing UI route | Needs backend verification |
| Onboarding curriculum setup | Induction + follow-ups schedule | Missing UI route | Missing UI route | No UI found |
| Annual requalification calendar | Generate renewal assignments batch | Missing UI route | Missing UI route | No UI found |
| Training plan versioning | Plan versions + migration choice | Missing UI route | Missing UI route | No UI found |
| Plan assignment preview | Simulation preview | Missing UI route | Missing UI route | No UI found |

## Document control
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Master document register | Controlled docs list | `/admin/documents/library` | Placeholder / mock data present | `documents/document_screens.dart` |
| Document upload & versioning | Upload + versions + hashes | `/admin/documents/upload` | Placeholder / mock data present | `document_screens.dart` |
| Controlled distribution list | Assign docs to roles/depts + e-sign ack requirements | `/admin/documents/ack` | Placeholder / mock data present | `document_screens.dart` |
| Periodic review scheduling | Review cycles + alerts | Missing UI route | Missing UI route | No UI found |
| Obsolescence & retirement | Retire doc with audit | Missing UI route | Missing UI route | No UI found |
| Acknowledgement compliance matrix | Who acknowledged + overdue red | `/admin/documents/ack` | Placeholder / mock data present | `document_screens.dart` |

## Approval config
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Define approval workflow templates | Create workflow templates | Missing UI route | Missing UI route | No UI found |
| Map templates to content types | Map templates to course/assessment/SOP/waiver/etc | Missing UI route | Missing UI route | No UI found |
| Approver assignment | Assign approvers + backup | Missing UI route | Missing UI route | No UI found |
| Delegation management | Delegate approvers for a period | Missing UI route | Missing UI route | No UI found |
| SLA breach escalation | Escalation chain | Missing UI route | Missing UI route | No UI found |
| Parallel vs sequential config | Sync/all-must-sign logic | Missing UI route | Missing UI route | No UI found |

## Compliance config
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Regulatory framework selection | Enable frameworks | `/admin/system/settings` | Missing / partial | `system_screens.dart` placeholder likely |
| ALCOA+ constraint configuration | Toggle enforcement constraints | `/admin/system/settings` | Missing / partial | `system_screens.dart` |
| Password & session policy | Min length/expiry/reuse + TTL per role | `/admin/system/settings` | Missing / partial | `system_screens.dart` |
| Minimum time-on-task rules | Floor minimum view seconds | Missing UI route | Missing UI route | No UI found |
| Assessment attempt lockout policy | Lockout/ceiling | Missing UI route | Missing UI route | No UI found |
| Data retention policy | Retention windows | `/admin/system/retention` | Placeholder / mock data present (verify) | `system/system_screens.dart` |
| Compliance gap alerting rules | Threshold-based alerting | `/admin/notifications/rules` | Placeholder / mock data present | `notification_screens.dart` reminder-rules placeholder |

## E-signature admin
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Configure signature meaning templates | Meaning templates CRUD | Missing UI route | Missing UI route | No UI found |
| Set re-authentication window | re_auth_window_seconds | Missing UI route | Missing UI route | No UI found |
| HMAC chain verification | Trigger on-demand verification | `/admin/audit/integrity` | Placeholder / mock data present (verify) | `audit_capa_screens.dart` / integrity screen |
| View signature audit log | esignatures table browse/export | `/admin/audit/trail` (best-effort) | Partial (audit trail UI) | `user_audit_trail_screen.dart` mock currently |
| Signature invalidation procedure | Mark signatures invalid + e-sign | Missing UI route | Missing UI route | No UI found |

## Audit trail
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Audit trail architecture | Append-only enforcement | Server-side | Missing UI route | N/A |
| Real-time audit event browser | Browse audit events with filters | `/admin/audit/trail` | Placeholder / mock data present (verify) | `audit_trail_screen.dart` (if placeholder) |
| HMAC chain integrity check | Run integrity chain verification | `/admin/audit/integrity` | Placeholder / mock data present (verify) | `audit_integrity_screen.dart` (if placeholder) |
| Anomaly detection alerts | Show anomaly alerts | `/admin` / reports screens | Missing / partial | Needs implementation |
| Data correction procedure | Create addendum records | Missing UI route | Missing UI route | No UI found |
| Immutability testing | Run immutability self-test | Missing UI route | Missing UI route | No UI found |
| Audit log archive & export | Export signed CSV of audit logs | `/admin/audit/trail` | Partial | Depends on export wiring |

## Reports & inspection
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Compliance dashboard — platform level | Overall KPIs + overdue + open approvals | `/admin` or `/admin/reports/compliance` | Placeholder / mock data present | `admin_dashboard_screen_v2.dart` uses placeholder queues |
| Training compliance matrix | Cross-tab employees × mandatory courses | Missing / partial | Missing UI route | Possibly `/admin/job-specs/matrix` but placeholder? |
| Gap analysis report | Incomplete mandatory by due date | `/admin/reports/gap` | Placeholder / mock data present (verify) | `report_screens.dart` |
| User access review report | Users/roles/last-login export | `/admin/users/access-review` | Stubbed action | `access_review_screen.dart` stubs |
| Assessment analytics report | pass rate, most-failed, top learners | `/admin/analytics/dashboard` | Placeholder / mock data present | `analytics_screens.dart` |
| Inspection evidence package | One-click ZIP export | Missing UI route | Missing UI route | No UI found |
| Scheduled reporting | Auto-generated reports config | `/admin/reports/scheduled` | Placeholder / mock data present | `report_screens.dart` |

## Notifications & escalations
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| Notification template management | Template CRUD + variables | `/admin/notifications/templates` | Implemented (validate) | `notification_screens.dart` templates section |
| Channel configuration | Enable in-app/email/SMS channels | `/admin/notifications/templates` | Partial / verify | In templates UI |
| Escalation chain configuration | Cadence + escalation ladder | `/admin/notifications/rules` | Placeholder / mock data present | `notification_screens.dart` reminder-rules placeholder |
| Do-not-disturb windows | Quiet hours per site | Missing UI route | Missing UI route | No UI found |
| Notification delivery audit | Delivery log | Missing UI route | Missing UI route | No UI found |

## Integrations
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| HR system integration (SCIM) | SCIM endpoint + sync log | `/admin/system/hr-integration` | Placeholder / mock data present (verify) | `system/system_screens.dart` |
| SSO / SAML configuration | SSO IdP configuration | Missing UI route | Missing UI route | No UI found |
| SCORM / xAPI runtime config | LRS config | Missing UI route | Missing UI route | No UI found |
| S3 / MinIO storage config | Bucket endpoints + hashes | Missing UI route | Missing UI route | No UI found |
| Email / SMTP configuration | SMTP creds + test email | Missing UI route | Missing UI route | No UI found |
| API key management | Issue/rotate/revoke API keys | `/admin/system/api-keys` | Placeholder / mock data present (verify) | `system/system_screens.dart` |

## System health & DR
| HTML step | Expected capability | Admin route(s) | Status | Current hotspot(s) |
|---|---|---|---|---|
| System health dashboard | P95/P99, consumer lag, DB pool, S3 health | `/admin/system/health` | Placeholder / mock data present (verify) | `system/system_screens.dart` |
| Database backup monitoring | Backup timestamps + restore test result | Missing UI route | Missing UI route | No UI found |
| Restore / DR drill | Trigger DR drill | Missing UI route | Missing UI route | No UI found |
| Data integrity scan | HMAC chain + SHA checks | `/admin/audit/integrity` | Placeholder / mock data present (verify) | integrity screen |
| Kafka cluster health | DLQ review | Missing UI route | Missing UI route | No UI found |
| Maintenance mode | Maintenance toggle + e-sign | Missing UI route | Missing UI route | No UI found |

## Notes / known mismatches discovered while mapping
- `AdminUserDirectoryScreen` “Import” and “Create User” buttons push to `/admin/users/import` and `/admin/users/create`, but those legacy routes are commented out in `app_router.dart`. The correct paths for the real screens are likely:
  - `/admin/users/directory/import`
  - `/admin/users/directory/create`
- Several `/admin/*` routes map to placeholder templates that currently render `AdminPlaceholderTable` with “Coming Soon” rows.
- Several user identity workflows are stubbed:
  - role assignment (`user_role_assignment_screen.dart`)
  - user audit trail mock (`user_audit_trail_screen.dart`)
  - bulk import simulated preview/success (`user_bulk_import_screen.dart`)
  - access review actions simulated by `Future.delayed` (`access_review_screen.dart`)

