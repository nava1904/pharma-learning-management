# Pharma LMS - Enterprise Pharmaceutical Learning Management System

Enterprise-grade compliance LMS for pharmaceutical companies. Built for FDA 21 CFR Part 11, GxP, EU Annex 11, and ALCOA+ data integrity.

## Tech Stack

- **Frontend**: Flutter 3.x, Riverpod, GoRouter, Material 3
- **Backend**: Serverpod (Dart), PostgreSQL, Redis
- **Event Bus**: Kafka (optional)
- **Storage**: S3/MinIO for documents

## Project Structure

```
pharma_lms/
├── pharma_lms_server/     # Serverpod backend
├── pharma_lms_client/     # Auto-generated client
├── pharma_lms_flutter/    # Flutter app
└── docker/                # Docker configs
```

## Quick Start

See **[docs/LOCAL_DEVELOPMENT_SETUP.md](../docs/LOCAL_DEVELOPMENT_SETUP.md)** for the full step-by-step guide.

### TL;DR

```bash
# 1. Start PostgreSQL
cd pharma_lms_server && docker compose up -d postgres

# 2. Run server
serverpod run

# 3. Build Flutter app (in another terminal)
serverpod run flutter_build
# Then open http://localhost:8082/app
```

## Domains

1. **Organization & Identity** - Multi-tenant, sites, departments, users
2. **Course & Curriculum** - Versioned courses, modules, lessons
3. **Training Assignment** - Assignments, enrollments, certificates
4. **Assessment Engine** - Question banks, assessments, attempts
5. **Document Control** - Documents, versions, lifecycle
6. **Compliance Engine** - Department compliance, SLA policies
7. **Quality Event** - CAPA, change control, inspections
8. **Audit & Validation** - Immutable audit trail, access logs

## Compliance

- **Audit Trail**: Append-only, every mutation logged
- **Electronic Signatures**: Required for training completion
- **Document Versioning**: Immutable history
- **Access Logging**: Login, session, IP tracking

## API Endpoints

- `organization` - Organizations, sites, departments, users
- `course` - Courses, versions, modules
- `training` - Assignments, enrollments, certificates
- `audit` - Audit trail, access logs
- `compliance` - Department compliance metrics

## Deployment

| Component | Platform | Status |
|-----------|----------|--------|
| Frontend | Vercel | ![Vercel](https://img.shields.io/badge/Vercel-Deployed-green) |
| Backend | Render | ![Render](https://img.shields.io/badge/Render-Deployed-green) |
| Database | Render PostgreSQL | ![DB](https://img.shields.io/badge/PostgreSQL-Managed-blue) |

See **[docs/DEPLOYMENT.md](../docs/DEPLOYMENT.md)** for full deployment guide.

## CI/CD

- **Frontend**: Auto-deploy to Vercel on push to `main`
- **Backend**: Auto-deploy to Render on push to `main`
- **Migrations**: Manual workflow dispatch
