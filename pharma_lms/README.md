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

### 1. Start Infrastructure

```bash
cd pharma_lms_server
docker compose up -d
```

### 2. Run Server

```bash
cd pharma_lms_server
dart bin/main.dart --apply-migrations
```

### 3. Run Flutter App

```bash
cd pharma_lms_flutter
flutter run -d chrome
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
